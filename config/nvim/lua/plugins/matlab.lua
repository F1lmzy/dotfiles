return {
  {
    "idossha/matlab.nvim",
    ft = "matlab", -- Plugin loads only when you open a MATLAB file
    config = function()
      require("matlab").setup()
    end,
  },
}
