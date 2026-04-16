-- ~/.config/nvim/lua/mappings.lua

require "nvchad.mappings"
local map = vim.keymap.set

-- Toggle NvChad transparency on the fly utilizing base46 compiled logic
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle Base46 Global Transparency" })
