require('obsidian').setup {
  workspaces = {
    {
      name = 'personal',
      path = '~/obsidian',
    },
  },
  daily_notes = {
    folder = '01-daily-notes',
    date_format = '%Y-%m-%d',
    template = '02-templates/daily',
  },
  disable_frontmatter = true,
  templates = {
    folder = '02-templates',
  },
}
