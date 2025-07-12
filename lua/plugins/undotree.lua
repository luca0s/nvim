return {
    "mbbill/undotree",

    config = function()
        local sysname = vim.loop.os_uname().sysname
        if sysname ~= "Linux" then
            vim.g.undotree_DiffCommand = "FC"
        end

        vim.g.undotree_SetFocusWhenToggle = true;
        vim.g.undotree_WindowLayout = 3;
        vim.g.undotree_WindowLayout = 3;
        vim.g.undotree_SplitWidth = 40;
        vim.g.undotree_DiffpanelHeight = 20;
    end
}
