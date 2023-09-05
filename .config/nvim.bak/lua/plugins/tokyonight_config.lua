-- Colorscheme config
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
    "neotest-summary",
    "nofile",
  },
  on_highlights = function(hl, c)
    -- hl.Substitute = {
    --   sp = hl.Substitute.bg,
    --   bg = "none",
    --   underline = true,
    -- }
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
    hl.HlSearchLens = hl.EndOfBuffer
    hl.HlSearchLensNear = hl.EndOfBuffer
    hl.HLSearchNear = hl.CurSearch
    hl.HLSearchFloat = hl.CurSearch
    hl.GitSignsCurrentLineBlame = hl.Comment
    hl.typescriptParens = { fg = c.fg }
    hl.SignatureMarkText = { fg = c.blue, bold = true }
    hl.NotifyBackground = hl.Normal

    local util = require("tokyonight.util")
    hl.Search = { bg = util.darken(c.blue0, 0.5), fg = c.fg }
    hl.CurSearch = { bg = c.blue0, fg = c.fg }

    -- Telescope
    hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
    hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
    hl.TelescopePromptNormal = { bg = c.bg_dark }
    hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
    hl.TelescopePromptTitle = { bg = c.bg_dark, fg = c.fg_dark }
    hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.fg_dark }
    hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }

    -- Barbar.nvim
    local black = "#1D202F"
    hl.BufferCurrent = { bg = c.bg, fg = c.fg }
    hl.BufferCurrentIndex = { bg = c.bg, fg = c.blue }
    hl.BufferCurrentMod = hl.BufferCurrent
    hl.BufferCurrentSign = { bg = c.bg, fg = c.blue }
    hl.BufferCurrentTarget = { bg = c.bg_dark, fg = c.red }
    hl.BufferVisible = { bg = c.bg_dark, fg = c.fg }
    hl.BufferVisibleIndex = { bg = c.bg_dark, fg = "#abb2bf" }
    hl.BufferVisibleMod = hl.BufferVisible
    hl.BufferVisibleSign = { bg = c.bg_dark, fg = black }
    hl.BufferVisibleTarget = { bg = c.bg_dark, fg = c.red }
    hl.BufferInactive = { bg = c.bg_dark, fg = c.dark5 }
    hl.BufferInactiveIndex = { bg = c.bg_statusline, fg = black }
    hl.BufferInactiveMod = hl.BufferInactive
    hl.BufferInactiveSign = { bg = c.bg_dark, fg = black }
    hl.BufferInactiveTarget = { bg = c.bg_statusline, fg = c.red }
    hl.BufferTabpages = { bg = c.bg_statusline, fg = c.fg, bold = true }
    hl.BufferTabpageFill = { bg = black, fg = black }

    -- Neotest
    hl.NeotestIndent = { fg = c.fg_gutter }
    hl.NeotestDir = { fg = c.blue }
    hl.NeotestFile = { fg = "#6183bb" }
    hl.NeotestNamespace = { fg = c.cyan }
    hl.NeotestFocused = hl.CursorLine
    hl.NeotestTest = { fg = c.fg, italic = true }
    hl.NeotestAdapterName = { fg = c.blue, bold = true }
    hl.NeotestUnknown = { fg = c.fg }
    hl.NeotestFailed = { fg = c.red1 }
  end,
})
