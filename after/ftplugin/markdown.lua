vim.opt.conceallevel = 0
vim.keymap.set("n", "<leader>td", "<cmd>s/^\\{-\\}- \\[.\\{-\\}]/\\1- [x]<cr>")
vim.keymap.set("n", "<leader>tp", "<cmd>s/^\\{-\\}- \\[.\\{-\\}]/\\1- [-]<cr>")
vim.keymap.set("n", "<leader>tu", "<cmd>s/^\\{-\\}- \\[.\\{-\\}]/\\1- [ ]<cr>")
vim.keymap.set("n", "<leader>ta", "^i- [ ] <C-c>")
vim.keymap.set("n", "<leader>tr", "<cmd>s/^\\{-\\}- \\[.\\{-\\}]/\\1<cr>^X")
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.linebreak = true
vim.opt.smartindent = true
vim.opt.colorcolumn = ""
