return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Use Mason to install and setup language servers
        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Replace the language servers listed here
            -- with the ones you want to install
            ensure_installed = {'lua_ls', 'rust_analyzer'},
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({ capabilities = capabilities })
                end,

                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        on_init = function(client)
                            if client.workspace_folders then
                                local path = client.workspace_folders[1].name
                                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                                    return
                                end
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                                runtime = {
                                    version = 'LuaJIT'
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                    }
                                }
                            })
                        end,
                        settings = {
                            Lua = {}
                        }
                    })
                end
            },
        })
    end
}
