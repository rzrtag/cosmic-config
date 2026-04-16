-- ~/.config/nvim/lua/configs/lspconfig.lua
-- Modernized for Neovim 0.11+ / 0.12-dev API

local nv_lsp = require("nvchad.configs.lspconfig")
local on_attach = nv_lsp.on_attach
local on_init = nv_lsp.on_init
local capabilities = nv_lsp.capabilities

local servers = { "html", "cssls", "pyright", "ts_ls", "lua_ls" }

-- Use the new Neovim LSP configuration API to avoid deprecation warnings
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end
