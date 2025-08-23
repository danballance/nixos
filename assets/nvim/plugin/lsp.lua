-- Enhanced LSP configuration with error handling and better defaults

-- Diagnostics configuration
vim.diagnostic.config({
  severity_sort = true,
  float = { 
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    }
  },
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
  update_in_insert = false,
})

-- Check if required modules are available
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify('lspconfig not found', vim.log.levels.ERROR)
  return
end

local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmp_lsp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Enhanced capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local on_attach = function(client, bufnr)
  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  -- Navigation
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
  
  -- Documentation
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  
  -- Actions
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
end

-- Server configurations with specific settings
local servers = {
  nixd = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "nixpkgs-fmt" },
        },
      },
    },
  },
  
  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init_options = {
      preferences = {
        disableSuggestions = false,
      },
    },
  },
  
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = true,
      },
    },
  },
}

-- Setup servers with error handling
for server, config in pairs(servers) do
  if lspconfig[server] then
    config.capabilities = capabilities
    config.on_attach = on_attach
    
    -- Check if server executable exists
    if config.cmd and vim.fn.executable(config.cmd[1]) == 0 then
      vim.notify(string.format('LSP server %s not found in PATH', config.cmd[1]), vim.log.levels.WARN)
    else
      lspconfig[server].setup(config)
    end
  else
    vim.notify(string.format('Unknown LSP server: %s', server), vim.log.levels.WARN)
  end
end

-- Configurable auto-format on save
local format_on_save_filetypes = {
  "lua", "nix", "python", "rust", "javascript", "typescript", 
  "javascriptreact", "typescriptreact"
}

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('LspFormat', { clear = true }),
  callback = function(event)
    local filetype = vim.bo[event.buf].filetype
    if vim.tbl_contains(format_on_save_filetypes, filetype) then
      local clients = vim.lsp.get_clients({ bufnr = event.buf })
      if #clients > 0 then
        vim.lsp.buf.format({ 
          bufnr = event.buf,
          async = false,  -- Synchronous for save to ensure completion
          timeout_ms = 3000,
        })
      end
    end
  end,
})

-- LSP status indicator (optional)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspStatusNotify', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client then
      vim.notify(string.format('LSP %s attached to buffer %d', client.name, event.buf), vim.log.levels.INFO)
    end
  end,
})
