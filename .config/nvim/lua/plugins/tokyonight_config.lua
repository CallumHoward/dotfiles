require("tokyonight").setup({
  style = "storm",
  styles = {
    keywords = { italic = false },
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = {
    "qf",
    "vista_kind",
    "Outline",
    "flutterToolsOutline",
    "terminal",
    "packer",
    "help",
    "UltestSummary",
    "nofile",
  },
  on_highlights = function(hl, c)
    hl.VimLcovCoveredLineSignText = {
      fg = "#1abc9c",
      bg = "none",
    }
    hl.VimLcovUncoveredLineSignText = {
      fg = "#1abc9c",
      bg = "none",
    }
    hl.SymbolsOutlineConnector = hl.IndentBlanklineChar
    hl.FocusedSymbol = hl.CursorLine
    hl.Folded = hl.StatusLineNC
    hl.NvimTreeFolderIcon = hl.Directory
    hl.HlSearchLens = hl.EndOfBuffer
    hl.HlSearchLensNear = hl.EndOfBuffer
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = c.bg_dark,
    }
    hl.TelescopePromptBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptTitle = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})
