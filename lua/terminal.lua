local M = {}

local augroup = vim.api.nvim_create_augroup("BottomTerminal", {
	clear = true,
})

local terminal = {
	buf = nil,
	win = nil,
	height = 15,
}

local function buffer_is_valid()
	return terminal.buf and vim.api.nvim_buf_is_valid(terminal.buf)
end

local function window_is_valid()
	return terminal.win
		and vim.api.nvim_win_is_valid(terminal.win)
		and buffer_is_valid()
		and vim.api.nvim_win_get_buf(terminal.win) == terminal.buf
end

local function configure_window(win)
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
end

local function create_terminal_buffer()
	terminal.buf = vim.api.nvim_create_buf(false, true)
	vim.bo[terminal.buf].bufhidden = "hide"

	local job_id = vim.api.nvim_buf_call(terminal.buf, function()
		return vim.fn.jobstart(vim.o.shell, {
			term = true,
		})
	end)

	if job_id <= 0 then
		vim.notify("Failed to start terminal shell", vim.log.levels.ERROR)

		vim.api.nvim_buf_delete(terminal.buf, {
			force = true,
		})

		terminal.buf = nil
		return false
	end

	return true
end

function M.open()
	if window_is_valid() then
		vim.api.nvim_set_current_win(terminal.win)
		vim.cmd("startinsert")
		return
	end

	terminal.win = nil

	if not buffer_is_valid() then
		if not create_terminal_buffer() then
			return
		end
	end

	vim.cmd("botright split")

	terminal.win = vim.api.nvim_get_current_win()

	vim.api.nvim_win_set_buf(terminal.win, terminal.buf)

	vim.api.nvim_win_set_height(terminal.win, terminal.height)

	configure_window(terminal.win)

	vim.cmd("startinsert")
end

function M.close()
	if not window_is_valid() then
		terminal.win = nil
		return
	end

	terminal.height = vim.api.nvim_win_get_height(terminal.win)

	vim.api.nvim_win_close(terminal.win, false)

	terminal.win = nil
end

function M.toggle()
	if window_is_valid() then
		M.close()
	else
		M.open()
	end
end

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function(args)
		if args.buf ~= terminal.buf then
			return
		end

		if window_is_valid() then
			configure_window(terminal.win)
		end
	end,
})

vim.api.nvim_create_autocmd("WinClosed", {
	group = augroup,
	callback = function(args)
		local closed_win = tonumber(args.match)

		if not closed_win then
			return
		end

		---@cast closed_win integer

		if closed_win ~= terminal.win then
			return
		end

		terminal.height = vim.api.nvim_win_get_height(closed_win)
		terminal.win = nil
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function(args)
		if args.buf ~= terminal.buf then
			return
		end

		local buf = terminal.buf
		local win = terminal.win
		local status = vim.v.event.status

		terminal.buf = nil
		terminal.win = nil

		vim.schedule(function()
			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end

			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, {
					force = true,
				})
			end

			if status ~= 0 then
				vim.notify("Terminal exited with status " .. status, vim.log.levels.WARN)
			end
		end)
	end,
})

return M
