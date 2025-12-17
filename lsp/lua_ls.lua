return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	-- settings = {
	--     Lua = {
	--         diagnostics = {
	--             --     disable = { "missing-parameters", "missing-fields" },
	--         },
	--     },
	-- },


	-- disable for premake files
	log_level = vim.lsp.protocol.MessageType.Warning,
	on_attach = function(client, bufnr)
		local fname = vim.api.nvim_buf_get_name(bufnr):match("[^/\\]+$")
		if fname:match("^premake.*%.lua$") then
			client.stop()
			return
		end
	end,
}
