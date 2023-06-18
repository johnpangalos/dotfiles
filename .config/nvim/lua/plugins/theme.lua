return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function()
      return {
        transparent_background = true,
        color_overrides = {
          latte = {},
          frappe = {},
          macchiato = {},
          mocha = {},
        },
      }
    end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      local auto_dark_mode = require("auto-dark-mode")
      local set_dark_mode = function()
        -- vim.api.nvim_set_option("background", "dark")
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        vim.cmd("colorscheme catppuccin")
      end
      local set_light_mode = function()
        -- vim.api.nvim_set_option("background", "light")
        vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha
        vim.cmd("colorscheme catppuccin")
      end

      auto_dark_mode.setup({
        update_interval = 1000,
        set_dark_mode = set_dark_mode,
        set_light_mode = set_light_mode,
      })

      local function start_job(cmd, opts)
        opts = opts or {}
        local id = vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          on_stdout = function(_, data, _)
            if data and opts.on_stdout then
              opts.on_stdout(data)
            end
          end,
          on_exit = function(_, data, _)
            if opts.on_exit then
              opts.on_exit(data)
            end
          end,
        })

        if opts.input then
          vim.fn.chansend(id, opts.input)
          vim.fn.chanclose(id, "stdin")
        end

        return id
      end

      local is_currently_dark_mode

      local function check_is_dark_mode(callback)
        start_job("defaults read -g AppleInterfaceStyle", {
          on_exit = function(exit_code)
            local is_dark_mode = exit_code == 0
            callback(is_dark_mode)
          end,
        })
      end

      local function change_theme_if_needed(is_dark_mode)
        if is_dark_mode == is_currently_dark_mode then
          return
        end

        is_currently_dark_mode = is_dark_mode
        if is_currently_dark_mode then
          set_dark_mode()
        else
          set_light_mode()
        end
      end

      check_is_dark_mode(change_theme_if_needed)

      auto_dark_mode.init()
    end,
  },
}
