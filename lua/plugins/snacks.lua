return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
    explorer = { enabled = true },
    dashboard = { enabled = true },
    bufdelete = { enabled = true },
    lazygit = { enabled = true },
  },
  keys = {
    -- explorer
    { "<leader>e",  function() Snacks.explorer() end },
    -- picker
    { "<leader>ff", function() Snacks.picker.files() end },
    { "<leader>fs", function() Snacks.picker.grep() end },
    { "<leader>fb", function() Snacks.picker.buffers() end },
    { "<leader>fg", function() Snacks.picker.git_files() end },
    { "<leader>u",  function() Snacks.picker.undo() end },
    -- bufdelete
    { "<leader>bd", function() Snacks.bufdelete.delete() end },
  },
}
