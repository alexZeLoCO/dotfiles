vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, border = "rounded", source = "always" })
    end
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.tpp",
  callback = function() vim.bo.filetype = "cpp" end,
})

