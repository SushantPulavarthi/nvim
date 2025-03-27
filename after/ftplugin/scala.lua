vim.opt.shiftwidth = 4
-- Set makeprg for Scala compilation using sbt
-- vim.api.nvim_buf_set_option(0, 'makeprg', 'scala compile . | sed \'s/\\x1b\\[[0-9;]*m//g\'')
-- vim.opt_local.makeprg = 'scala compile .'
-- vim.api.nvim_buf_set_option(0, 'errorformat', '%s %f:%l:%c')
-- vim.api.nvim_buf_set_option(0, 'efm', '%E%s %f:%l:%c,\\ line\\ %l%.%#,%Z%[%^\\ ]%\\@=%m')
-- vim.api.nvim_buf_set_option(0, 'efm', '%E%s %f:%l:%c,\\ line\\ %.%#,%Z%[%^\\ ]%\\@=%m')
-- vim.api.nvim_buf_set_option(0, 'efm', '%s %f:%l:%c')

vim.api.nvim_buf_set_option(0, 'makeprg', 'scala compile . 2>&1 \\| sed -r "s/\\x1b\\[[0-9;]*[mk]//g"')

-- vim.api.nvim_buf_set_option(0, "efm", [[
-- %E[error]\ ./%.%#:%l:%c,
-- %C[error]\ Found:\ %m,
-- %C[error]\ Required:\ %m,
-- %Z[error]%.%#,
-- %+EError\ compiling%.%#,
-- %+WWarning:\ %.%#,
-- %+C%.%#,
-- %-G%.%#
-- ]])
--
-- vim.api.nvim_buf_set_option(0, 'efm', "%A[warn]\\ %f:%l:%c,%C[warn]\\ %m,%C[warn],%C[warn]\\ %p^,%Z")
vim.api.nvim_buf_set_option(0, 'efm', "%A[%.%#]\\ %f:%l:%c,%C[%.%#]\\ %m,%C[%.%#],%C[%.%#]\\ %p^,%Z")
-- vim.api.nvim_buf_set_option(0, 'errorformat', "[warn]\\ %f:%l:%c,^.^#")
--
--
-- vim.opt.errorformat="%E\\ %#[error]\\ %#%f:%l:%c:\\ %m,%Z\\ %#[error]\\ %p^,%-G\\ %#[error]\\ %m"
-- vim.opt.errorformat+="%W\\ %#[warn]\\ %#%f:%l:%c:\\ %m,%Z\\ %#[warn]\\ %p^,%-G\\ %#[warn]\\ %m"
-- vim.opt.errorformat+="%E%f:%l:\\ error:\\ %m,%Z%p^,%-G%.%#"
