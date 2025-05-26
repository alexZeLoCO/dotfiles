require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local cmp = require("cmp")

-- Setup completion
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

-- Enable servers
local servers = { "pyright", "bashls", "clangd", "omnisharp", "jdtls", "ts_ls", "html" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
end

-- Format on save
local lsp_format_on_save = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = "LspFormat", buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        lsp_format_on_save(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
    end,
    settings = {
        format = { enable = true }, -- optional, if you want formatting
    },
})


