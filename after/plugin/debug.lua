vim.pack.add {
  { src = 'https://codeberg.org/mfussenegger/nvim-dap' },
}

local dap = require 'dap'
if not dap.adapters then
  dap.adapters = {}
end

-- Rust config
dap.adapters['probe-rs-debug'] = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'probe-rs',
    args = { 'dap-server', '--port', '${port}' },
  },
}
require('dap.ext.vscode').type_to_filetypes['probe-rs-debug'] = { 'rust' }
dap.listeners.before['event_probe-rs-rtt-channel-config']['plugins.nvim-dap-probe-rs'] = function(session, body)
  local utils = require 'dap.utils'
  utils.notify(string.format('probe-rs: Opening RTT channel %d with name "%s"!', body.channelNumber, body.channelName))
  local file = io.open('probe-rs.log', 'a')
  if file then
    file:write(
      string.format(
        '%s: Opening RTT channel %d with name "%s"!\n',
        os.date '%Y-%m-%d-T%H:%M:%S',
        body.channelNumber,
        body.channelName
      )
    )
  end
  if file then
    file:close()
  end
  session:request('rttWindowOpened', { body.channelNumber, true })
end
dap.listeners.before['event_probe-rs-rtt-data']['plugins.nvim-dap-probe-rs'] = function(_, body)
  local message =
    string.format('%s: RTT-Channel %d - Message: %s', os.date '%Y-%m-%d-T%H:%M:%S', body.channelNumber, body.data)
  local repl = require 'dap.repl'
  repl.append(message)
  local file = io.open('probe-rs.log', 'a')
  if file then
    file:write(message)
  end
  if file then
    file:close()
  end
end
dap.listeners.before['event_probe-rs-show-message']['plugins.nvim-dap-probe-rs'] = function(_, body)
  local message = string.format('%s: probe-rs message: %s', os.date '%Y-%m-%d-T%H:%M:%S', body.message)
  local repl = require 'dap.repl'
  repl.append(message)
  local file = io.open('probe-rs.log', 'a')
  if file then
    file:write(message)
  end
  if file then
    file:close()
  end
end
