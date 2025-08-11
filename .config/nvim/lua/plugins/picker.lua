return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type Snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = {
        enabled = true,
        ui_select = true,
        matcher = {
          frecency = true,
          sort_empty = true,
        },
        sources = {
          files = {
            hidden = true,
          },
          git_files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
    },
    keys = {
      -- Your existing keybindings mapped to Snacks
      {
        ";",
        function() Snacks.picker.buffers({ sort_lastused = true, layout = { preset = "vscode" } }) end,
        desc = "Switch Buffer",
      },
      {
        "<D-p>",
        function()
          Snacks.picker.smart({ layout = { preset = "vscode" } })
        end,
        desc = "Search files",
      },
      {
        "<D-F>",
        function() Snacks.picker.grep() end,
        desc = "Live grep",
      },

      -- Additional powerful Snacks pickers
      { "<leader><space>", function() Snacks.picker.smart() end,                      desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                    desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                       desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,            desc = "Command History" },

      -- Find
      { "<leader>ff",      function() Snacks.picker.files() end,                      desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                  desc = "Find Git Files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                     desc = "Recent Files" },

      -- Git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,               desc = "Git Branches" },
      { "<leader>gl",      function() Snacks.picker.git_log() end,                    desc = "Git Log" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                 desc = "Git Status" },
      { "<leader>gB",      function() Snacks.git.blame_line() end,                    desc = "Git Blame Line" },
      { "<leader>gt",      "<cmd>GitBlameToggle<cr>",                              desc = "Toggle Git Blame" },

      -- Search
      { "<leader>sw",      function() Snacks.picker.grep_word({ hidden = true }) end, desc = "Grep Word",       mode = { "n", "x" } },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                desc = "Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                       desc = "Help Pages" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                    desc = "Keymaps" },
      { "<leader>sr",      function() Snacks.picker.resume() end,                     desc = "Resume" },

      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,            desc = "Goto Definition" },
      { "gr",              function() Snacks.picker.lsp_references() end,             desc = "References" },
    },
  },
}
