return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- make sure to load this before all other plugins
    config = function()
      -- configure gruvbox here
      vim.o.background = "dark" -- set background to dark
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
