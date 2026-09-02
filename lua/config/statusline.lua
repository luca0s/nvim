local M = {}

local augroup = vim.api.nvim_create_augroup("CustomStatusline", {
	clear = true,
})

-- ---------------------------------------------------------------------------
-- Highlights
-- ---------------------------------------------------------------------------

local function setup_highlights()
	local pms = vim.api.nvim_get_hl(0, {
		name = "PmenuSel",
		link = false,
	})

	local dir = vim.api.nvim_get_hl(0, {
		name = "Directory",
		link = false,
	})

	local vis = vim.api.nvim_get_hl(0, {
		name = "Visual",
		link = false,
	})

	vim.api.nvim_set_hl(0, "StlMode", {
		fg = pms.fg,
		bg = vis.bg,
	})

	vim.api.nvim_set_hl(0, "StlGit", {
		fg = dir.fg,
		bg = pms.bg,
	})
end

setup_highlights()

-- Recreate our highlights whenever the colorscheme changes.
vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup,
	callback = setup_highlights,
})

-- ---------------------------------------------------------------------------
-- Modes
-- ---------------------------------------------------------------------------

local modes = {
	n = "NORMAL",
	no = "NORMAL",
	nov = "NORMAL",
	noV = "NORMAL",
	["no\22"] = "NORMAL",

	i = "INSERT",
	ic = "INSERT",
	ix = "INSERT",

	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",

	c = "COMMAND",

	R = "REPLACE",
	Rc = "REPLACE",
	Rx = "REPLACE",

	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",

	t = "TERMINAL",
}

-- ---------------------------------------------------------------------------
-- Git
-- ---------------------------------------------------------------------------

local function git(args, cwd)
	local cmd = { "git" }
	vim.list_extend(cmd, args)

	-- vim.system() can itself error if cwd doesn't exist,
	-- so protect it as well.
	local ok, process = pcall(vim.system, cmd, {
		cwd = cwd,
		text = true,
	})

	if not ok then
		return nil
	end

	local result = process:wait()

	if result.code ~= 0 then
		return nil
	end

	local output = vim.trim(result.stdout or "")

	if output == "" then
		return nil
	end

	return output
end

local function update_git_info(buf)
	-- Important:
	-- terminal buffers have names like:
	--
	-- term://C:/...
	--
	-- They are NOT filesystem paths and must not be passed
	-- to vim.system(..., { cwd = ... }).
	if vim.bo[buf].buftype ~= "" then
		vim.b[buf].git_branch = nil
		vim.b[buf].rel_path = nil
		return
	end

	local file = vim.api.nvim_buf_get_name(buf)

	-- [No Name]
	if file == "" then
		vim.b[buf].git_branch = nil
		vim.b[buf].rel_path = nil
		return
	end

	local file_dir = vim.fs.dirname(file)

	if not file_dir then
		vim.b[buf].git_branch = nil
		vim.b[buf].rel_path = nil
		return
	end

	local root = git({
		"rev-parse",
		"--show-toplevel",
	}, file_dir)

	-- Not inside a Git repository.
	if not root then
		vim.b[buf].git_branch = nil
		vim.b[buf].rel_path = vim.fn.fnamemodify(file, ":~:.")
		return
	end

	local branch = git({
		"branch",
		"--show-current",
	}, file_dir)

	-- Detached HEAD fallback.
	if not branch then
		branch = git({
			"rev-parse",
			"--short",
			"HEAD",
		}, file_dir)
	end

	vim.b[buf].git_branch = branch

	local normalized_file = vim.fs.normalize(file)
	local normalized_root = vim.fs.normalize(root)

	-- Git told us that the file is inside this repository,
	-- so strip the repository root from the displayed path.
	if normalized_file:sub(1, #normalized_root):lower() == normalized_root:lower() then
		vim.b[buf].rel_path = normalized_file:sub(#normalized_root + 2)
	else
		vim.b[buf].rel_path = vim.fn.fnamemodify(file, ":~:.")
	end
end

-- ---------------------------------------------------------------------------
-- Statusline components
-- ---------------------------------------------------------------------------

local function escape_statusline(text)
	return text:gsub("%%", "%%%%")
end

local function get_mode()
	local current = vim.api.nvim_get_mode().mode

	return modes[current] or modes[current:sub(1, 1)] or current:upper()
end

local function get_branch()
	local branch = vim.b.git_branch

	if not branch or branch == "" then
		return ""
	end

	return "%#StlGit#  " .. escape_statusline(branch) .. " %*"
end

local function get_path()
	local buftype = vim.bo.buftype

	if buftype == "terminal" then
		return "Terminal"
	end

	if buftype == "help" then
		return "%f"
	end

	if buftype == "quickfix" then
		return "Quickfix"
	end

	if buftype ~= "" then
		local name = vim.api.nvim_buf_get_name(0)

		if name == "" then
			return "[No Name]"
		end

		return escape_statusline(vim.fn.fnamemodify(name, ":t"))
	end

	local path = vim.b.rel_path

	if not path or path == "" then
		local name = vim.api.nvim_buf_get_name(0)

		if name == "" then
			return "[No Name]"
		end

		path = vim.fn.fnamemodify(name, ":~:.")
	end

	path = escape_statusline(path)

	if vim.bo.modified then
		path = path .. " [+]"
	end

	if not vim.bo.modifiable then
		path = path .. " [-]"
	end

	return path
end

local function get_diagnostics()
	local counts = vim.diagnostic.count(0)

	local parts = {}

	local diagnostics = {
		{
			severity = vim.diagnostic.severity.ERROR,
			icon = " ",
			hl = "DiagnosticError",
		},
		{
			severity = vim.diagnostic.severity.WARN,
			icon = " ",
			hl = "DiagnosticWarn",
		},
		{
			severity = vim.diagnostic.severity.INFO,
			icon = " ",
			hl = "DiagnosticInfo",
		},
		{
			severity = vim.diagnostic.severity.HINT,
			icon = " ",
			hl = "DiagnosticHint",
		},
	}

	for _, item in ipairs(diagnostics) do
		local count = counts[item.severity] or 0

		if count > 0 then
			table.insert(parts, "%#" .. item.hl .. "#" .. item.icon .. count .. "%*")
		end
	end

	return table.concat(parts, " ")
end

-- ---------------------------------------------------------------------------
-- Render
-- ---------------------------------------------------------------------------

function M.render()
	local mode = get_mode()
	local branch = get_branch()
	local path = get_path()
	local diagnostics = get_diagnostics()

	local left = "%#StlMode# " .. mode .. " %*"

	if branch ~= "" then
		left = left .. " " .. branch
	end

	left = left .. " " .. path

	local right = ""

	if diagnostics ~= "" then
		right = diagnostics .. " "
	end

	if vim.bo.filetype ~= "" then
		right = right .. escape_statusline(vim.bo.filetype) .. " "
	end

	right = right .. "%l:%c"

	return left .. "%=" .. right
end

-- ---------------------------------------------------------------------------
-- Autocommands
-- ---------------------------------------------------------------------------

vim.api.nvim_create_autocmd({
	"BufEnter",
	"BufFilePost",
}, {
	group = augroup,
	callback = function(args)
		update_git_info(args.buf)
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = augroup,
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

-- ---------------------------------------------------------------------------
-- Enable
-- ---------------------------------------------------------------------------

_G._statusline = M.render

vim.o.statusline = "%!v:lua._statusline()"

return M
