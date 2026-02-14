return {
  name = "g++ run",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "g++" },
      args = { "-std=c++20", "-Wall", "-O2", file, "-o", "a.out" },
      components = { "default" },
      strategy = { "toggleterm", direction = "horizontal" },
    }
  end,
}
