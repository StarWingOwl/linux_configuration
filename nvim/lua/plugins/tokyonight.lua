return {

  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,

      on_highlights = function(hl)
        hl.Normal = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
