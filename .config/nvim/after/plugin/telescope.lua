local telescope = require('telescope')
telescope.setup {
    pickers = {
        find_files = {
            hidden = true
        }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>c', builtin.commands, {})
vim.keymap.set('n', '<leader><leader>', function()
    local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree'):match('true')
    if is_git_repo then
        builtin.git_files()
    else
        builtin.live_grep()
    end
end, {})
vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})

