local command = vim.api.nvim_create_user_command

command('PackUpdate', function(args)
  local names = #args.fargs > 0 and args.fargs or nil
  vim.pack.update(names, { force = args.bang })
end, {
  bang = true,
  nargs = '*',
  desc = 'Update plugins (vim.pack); ! to skip confirmation',
  complete = function()
    return vim.tbl_map(function(p)
      return p.spec.name
    end, vim.pack.get())
  end,
})

command('PackRestore', function(args)
  vim.pack.update(nil, { force = args.bang, target = 'lockfile' })
end, {
  bang = true,
  desc = 'Restore plugins to lockfile revisions (vim.pack)',
})

command('PackStatus', function()
  local rows = {}
  for _, p in ipairs(vim.pack.get()) do
    rows[#rows + 1] = {
      active = p.active,
      name = p.spec.name,
      rev = (p.rev or ''):sub(1, 12),
    }
  end
  table.sort(rows, function(a, b)
    return a.name < b.name
  end)
  local lines = {}
  for _, r in ipairs(rows) do
    lines[#lines + 1] = ('%s %-24s %s'):format(r.active and '●' or '○', r.name, r.rev)
  end
  vim.print(table.concat(lines, '\n'))
end, { desc = 'List managed plugins (vim.pack): ● active, ○ inactive' })

command('PackClean', function()
  local inactive = vim
    .iter(vim.pack.get())
    :filter(function(p)
      return not p.active
    end)
    :map(function(p)
      return p.spec.name
    end)
    :totable()

  if #inactive == 0 then
    vim.notify('vim.pack: no inactive plugins to remove', vim.log.levels.INFO)
    return
  end

  local prompt = 'Remove ' .. #inactive .. ' plugin(s)?\n  ' .. table.concat(inactive, '\n  ')
  vim.ui.select({ 'yes', 'no' }, { prompt = prompt }, function(choice)
    if choice == 'yes' then
      vim.pack.del(inactive)
    end
  end)
end, { desc = 'Remove inactive plugins (vim.pack)' })
