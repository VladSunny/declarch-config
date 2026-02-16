return {
  "stevearc/overseer.nvim",
  optional = true,
  opts = {
    templates = { "builtin" },
  },
  keys = {
    { "<leader>rr", "<cmd>OverseerRun g++ run<cr>", desc = "Run C++" },
  },
}
