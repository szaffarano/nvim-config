local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.showmode = false
opt.laststatus = 3
opt.scrolloff = 10
opt.colorcolumn = '80,120'
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', conceal = '┊', eol = '↲', extends = '<', precedes = '>' }

opt.pumheight = 12

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = 'split'

opt.splitright = true
opt.splitbelow = true

opt.mouse = 'a'
opt.mousemodel = 'extend'
opt.clipboard = 'unnamed'
opt.breakindent = true
opt.wrap = false
opt.textwidth = 120
opt.spelllang = 'en,es,de,sv'
opt.updatetime = 250
opt.timeoutlen = 300
opt.modeline = true
opt.modelines = 5

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.undofile = true
opt.undolevels = 5000
opt.swapfile = false

opt.foldcolumn = 'auto'
opt.foldlevelstart = 99
opt.foldtext = ''
opt.fillchars:append { fold = ' ', foldopen = '', foldclose = '', foldsep = ' ' }

opt.formatoptions:remove 't'
