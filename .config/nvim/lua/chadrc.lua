-- ~/.config/nvim/lua/chadrc.lua

local M = {}

M.ui = {
  theme = "catppuccin",
  transparency = true, -- Initialize baseline transparency
  
  -- The hl_override logic forces all floating windows and structural columns 
  -- to obey the host terminal's alpha channel, overriding the base46 bytecode.
  hl_override = {
    Normal = { bg = "NONE" },
    NormalNC = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    NvimTreeEndOfBuffer = { fg = "NONE", bg = "NONE" },
    TelescopeNormal = { bg = "NONE" },
    TelescopePromptNormal = { bg = "NONE" },
    TelescopeResultsNormal = { bg = "NONE" },
    TelescopePreviewNormal = { bg = "NONE" },
    TelescopeBorder = { bg = "NONE" },
    TelescopePromptBorder = { bg = "NONE" },
    TelescopeResultsTitle = { bg = "NONE" },
    TelescopePromptTitle = { bg = "NONE" },
    TelescopePreviewTitle = { bg = "NONE" },
  },
}

return M
