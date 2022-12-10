require('lint').linters_by_ft = {
  vim = {'vint'},
  c = {'cppcheck'},
  cpp = {'cppcheck'},
  python = {'pylint'},
  -- typescript = {'eslint'},
  -- javascript = {'eslint'},
  haskell = {'hlint'},

  -- markdown = {'vale',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
