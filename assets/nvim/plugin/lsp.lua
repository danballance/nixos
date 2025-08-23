-- Diagnostics configuration
vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded' },
  signs = {
    text = {
    	[vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  }
})

local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>f', function() vim.lsp.buf.format({ async = false }) end, '[F]ormat buffer')
end

local servers = { nixd = {}, basedpyright = {}, ts_ls = {} }

for server, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(event)
    vim.lsp.buf.format({ bufnr = event.buf })
  end,
})

