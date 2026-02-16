return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function(_, opts)
      local dap = require("dap")

      dap.configurations.cpp = {
        {
          name = "Launch file (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/a.out", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- Можно также добавить конфиг под запуск с аргументами или через input()
    end,
  },
}
