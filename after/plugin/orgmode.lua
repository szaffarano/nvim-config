local org_base = '~/Documents/org.new'

vim.pack.add {
  { src = 'https://github.com/nvim-orgmode/orgmode' },
  { src = 'https://github.com/nvim-orgmode/org-bullets.nvim' },
  { src = 'https://github.com/chipsenkbeil/org-roam.nvim' },
  { src = 'https://github.com/itchyny/calendar.vim' },
}

require('orgmode').setup {
  org_agenda_files = {
    org_base .. '/captures/*.org',
    org_base .. '/roam/**/*.org',
  },
  org_startup_folded = 'showeverything',
  org_id_link_to_org_use_id = true,
  org_default_notes_file = org_base .. '/captures/refile.org',
  org_log_into_drawer = 'LOGBOOK',
  org_tags_column = -100,
  org_deadline_warning_days = 7,
  org_todo_keywords = { 'TODO(t)', 'PROGRESS(p)', '|', 'DONE(d)', 'REJECTED(r)' },
  win_border = 'single',
  win_split_mode = 'auto',
  ui = { input = { use_vim_ui = true } },
  mappings = {
    global = {
      org_agenda = '<leader>oa',
      org_capture = '<leader>oc',
    },
    org = {
      org_timestamp_up = '<A-k>',
      org_timestamp_down = '<A-j>',
    },
  },
  org_capture_templates = {
    r = {
      description = 'Refile',
      template = '* %?  :review: \n  SCHEDULED: %T',
    },
    t = {
      description = 'Personal todo',
      template = '* TODO %? :triage:\n  SCHEDULED: %T',
      target = org_base .. '/captures/todos.org',
      headline = 'Inbox',
      datetree = { tree_type = 'week', reversed = true }, ---@diagnostic disable-line
    },
    w = {
      description = 'Work todo',
      template = '* TODO %?  :triage: \n  SCHEDULED: %T',
      target = org_base .. '/captures/work.org',
      headline = 'Inbox',
      datetree = { tree_type = 'week', reversed = true }, ---@diagnostic disable-line
    },
    j = {
      description = 'Journal',
      template = '\n*** %U\n    %?',
      target = org_base .. '/captures/journal.org',
      datetree = { tree_type = 'week', reversed = true }, ---@diagnostic disable-line
    },
  },
  org_agenda_custom_commands = {
    z = {
      description = 'Weekly Zettelkasten triage',
      types = {
        {
          type = 'tags',
          match = 'review',
          org_agenda_overriding_header = 'Fleeting notes to triage',
          org_agenda_span = 'week',
        },
      },
    },
    c = {
      description = 'Combined view',
      types = {
        {
          type = 'tags_todo',
          match = '+PRIORITY="A"',
          org_agenda_overriding_header = 'High priority todos',
          org_agenda_todo_ignore_deadlines = 'far',
        },
        { type = 'agenda', org_agenda_overriding_header = 'Daily agenda', org_agenda_span = 'day' },
        {
          type = 'tags_todo',
          match = 'work',
          org_agenda_overriding_header = 'Work todos',
          org_agenda_todo_ignore_scheduled = 'all',
        },
        {
          type = 'tags_todo',
          match = 'personal',
          org_agenda_overriding_header = 'Personal todos',
          org_agenda_todo_ignore_scheduled = 'all',
        },
        {
          type = 'agenda',
          org_agenda_overriding_header = 'Week overview',
          org_agenda_span = 'week',
          org_agenda_start_on_weekday = 1,
          org_agenda_remove_tags = true,
        },
      },
    },
  },
}

require('org-bullets').setup { concealcursor = false, symbols = {} }

require('org-roam').setup {
  directory = org_base .. '/roam',
}

vim.api.nvim_create_user_command('Agenda', function()
  vim.schedule(function()
    local buf = vim.api.nvim_get_current_buf()
    local promise = Org.agenda.a()
    if promise ~= nil then
      promise:finally(function()
        vim.api.nvim_buf_delete(buf, { force = true })
      end)
    end
  end)
end, {})

vim.lsp.enable 'org'
