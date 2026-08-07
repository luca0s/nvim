local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

vim.api.nvim_set_hl(0, "StlMode", {
	fg = pms.fg,
	bg = vis.bg,
})

vim.api.nvim_set_hl(0, "StlGit", {
	fg = dir.fg,
	bg = pms.bg,
})

local modes = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "COMMAND",
	t = "TERMINAL",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
}

function _G._statusline()
	local current_mode = vim.fn.mode()
	local mode = modes[current_mode] or current_mode:upper()

	local branch = vim.b.git_branch and "%#StlGit#  " .. vim.b.git_branch .. " %*" or ""

	local path = vim.b.rel_path or "%f"

	local diag = ""
	local counts = vim.diagnostic.count(0)

	local labels = {
		" ",
		" ",
		" ",
		" ",
	}

	local hls = {
		"DiagnosticError",
		"DiagnosticWarn",
		"DiagnosticInfo",
		"DiagnosticHint",
	}

	for i = 1, 4 do
		if counts[i] and counts[i] > 0 then
			diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
		end
	end

	return "%#StlMode# " .. mode .. " %* " .. branch .. " " .. path .. "%=" .. diag .. vim.bo.filetype .. " %l:%c"
end

local function git(args, cwd)
	local cmd = { "git" }
	vim.list_extend(cmd, args)

	local result = vim.system(cmd, {
		cwd = cwd,
		text = true,
	}):wait()

	if result.code ~= 0 then
		return nil
	end

	return vim.trim(result.stdout or "")
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local file = vim.api.nvim_buf_get_name(0)

		if file == "" then
			vim.b.git_branch = nil
			vim.b.rel_path = "%f"
			return
		end

		local file_dir = vim.fs.dirname(file)
		local root = git({ "rev-parse", "--show-toplevel" }, file_dir)

		if root then
			local branch = git({ "branch", "--show-current" }, file_dir)

			if not branch or branch == "" then
				branch = git({ "rev-parse", "--short", "HEAD" }, file_dir)
			end

			vim.b.git_branch = branch

			local file_normalized = vim.fs.normalize(file)
			local root_normalized = vim.fs.normalize(root)

			if file_normalized:sub(1, #root_normalized) == root_normalized then
				vim.b.rel_path = file_normalized:sub(#root_normalized + 2)
			else
				vim.b.rel_path = vim.fn.fnamemodify(file, ":~")
			end
		else
			vim.b.git_branch = nil
			vim.b.rel_path = vim.fn.fnamemodify(file, ":~")
		end
	end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd("redrawstatus!")
	end,
})

vim.o.statusline = "%!v:lua._statusline()"
