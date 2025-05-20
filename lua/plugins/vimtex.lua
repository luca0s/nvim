return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
        vim.g.vimtex_compiler_latexmk = {
            build_dir = 'build',
            callback = 1,
            continuous = 1,
            executable = 'latexmk',
            options = {
                '-xelatex',
                '-file-line-error',
                '-interaction=nonstopmode',
                '-synctex=1',
            },
        }
    end
}
