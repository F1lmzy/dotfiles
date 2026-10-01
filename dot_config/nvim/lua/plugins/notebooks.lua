return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },
  {
    "goerz/jupytext.nvim",
    cond = function() return vim.fn.executable("jupytext") == 1 end,
    version = "0.2.0",
    opts = { format = "py:percent" },
  },
  {
    "wisteriahuman/colab.nvim",
    cond = function() return vim.fn.executable("uv") == 1 end,
    lazy = false,
    build = "uv sync",
    opts = {
      default_accelerator = "T4",
      auto_attach_molten = true,
    },
  },
}
