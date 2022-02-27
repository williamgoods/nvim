local vim = vim

local Path = require('plenary.path')
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
  path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
    'gitcommit',

  }, 
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
})

-- this is for lualine plugin
require('lualine').setup()

-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
          -- For `vsnip` user.
          -- vim.fn["vsnip#anonymous"](args.body)

          -- For `luasnip` user.
          -- require('luasnip').lsp_expand(args.body)

          -- For `ultisnips` user.
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<A-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    },
    sources = {
        { name = 'nvim_lsp' },

        -- For vsnip user.
        -- { name = 'vsnip' },

        -- For luasnip user.
        -- { name = 'luasnip' },

        -- For ultisnips user.
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = "crates" },
    }
})

-- this is for nvim_autopairs plugin
require('nvim-autopairs').setup{}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- this is for lspconfig plugin
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require'nvim-lsp-installer.servers'

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local languages_installer = {"sumneko_lua", "gopls", "pyright", "clangd", "cmake", "rust_analyzer"}

for _, language in ipairs(languages_installer) do
    local server_available, requested_server = lsp_installer_servers.get_server(language)
    if server_available then
        requested_server:on_ready(function ()
            local opts = {}
            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            -- Queue the server to be installed
            requested_server:install()
        end
    end
end

local lsp_installer_path = vim.fn.stdpath("data") .. "/lsp_servers/"

require'lspconfig'.gopls.setup{
   cmd = { lsp_installer_path .. "/go/gopls"}
}

require'lspconfig'.pyright.setup{}

require'lspconfig'.clangd.setup{}

require'lspconfig'.cmake.setup{}

require'lspconfig'.sumneko_lua.setup {
    cmd = { lsp_installer_path .. "sumneko_lua/extension/server/bin/lua-language-server" }
}

require'lspconfig'.rust_analyzer.setup{}

--vim.g.coc_global_extensions = {
    --'coc-vimlsp',
--}
