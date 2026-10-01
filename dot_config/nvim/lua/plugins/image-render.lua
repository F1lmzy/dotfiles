return {
  {
    "3rd/image.nvim",
    name = "image.nvim",
    -- Optional: requires ImageMagick and a Kitty-graphics-capable terminal.
    cond = function()
      return vim.fn.executable("magick") == 1
        and (vim.env.KITTY_WINDOW_ID ~= nil or vim.env.TERM == "xterm-kitty" or vim.env.TERM_PROGRAM == "ghostty")
    end,
    build = false, -- Use the ImageMagick CLI; no machine-specific LuaRocks paths
    config = function()
      require("image").setup({
        -- Target the system CLI tool directly
        processor = "magick_cli",
        backend = "kitty",

        max_width = 100,
        max_height = 12,
        max_height_window_percentage = 100,
        max_width_window_percentage = 100,

        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },

        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
      })
    end,
  },
}
