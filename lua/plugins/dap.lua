return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',

        'mason-org/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Language-specific debuggers
        "julianolf/nvim-dap-lldb",

        -- Shows variable values inline as virtual text
        'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
        {
            '<leader>ds',
            function()
                require('dap').continue()
            end,
            desc = 'Debug: Start/Continue',
        },
        {
            '<leader>dc',
            function()
                require('dap').run_to_cursor()
            end,
            desc = 'Debug: Run to Cursor',
        },
        {
            '<leader>dsi',
            function()
                require('dap').step_into()
            end,
            desc = 'Debug: Step Into',
        },
        {
            '<leader>dsO',
            function()
                require('dap').step_over()
            end,
            desc = 'Debug: Step Over',
        },
        {
            '<leader>dso',
            function()
                require('dap').step_out()
            end,
            desc = 'Debug: Step Out',
        },
        {
            '<leader>db',
            function()
                require('dap').toggle_breakpoint()
            end,
            desc = 'Debug: Toggle Breakpoint',
        },
        {
            '<leader>dB',
            function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = 'Debug: Set Conditional Breakpoint',
        },
        {
            '<leader>dt',
            function()
                require('dapui').toggle()
            end,
            desc = 'Debug: Toggle UI',
        },
        {
            '<leader>dl',
            function()
                require("nvim-dap-virtual-text").disable()
                require('dapui').toggle()
                require('dap').close()
            end,
            desc = 'Debug: Close',
        },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'


        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
                'codelldb',
            },
        }

        -- Dap UI setup
        dapui.setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Automatically open/close DAP UI
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Setup virtual text to show variable values inline
        require("nvim-dap-virtual-text").setup()

    end,
}
