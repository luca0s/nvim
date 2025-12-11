return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--all-scopes-completion", "--suggest-missing-includes" },
	filetypes = { "c", "cpp" },                                             -- File types that this server will handle
	root_markers = { ".git", ".clangd", "Makefile", "compile-commands.json" }, -- File types that this server will handle
}
