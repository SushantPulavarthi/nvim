local state = {
  floating = {
    buf = -1,
    win = -1,
    state = 0,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to centre the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    if state.floating.state ~= opts.state then
      vim.api.nvim_buf_delete(state.floating.buf, { force = true })
      print("Deleting old floating terminal")
      buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    else
      buf = opts.buf
    end
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function(opts)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf, state = opts.state }
    state.floating.state = opts.state
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal({ opts.cmd })
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<C-c><C-c>", "<c-\\><c-n>")
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>t", function()
  toggle_terminal { state = 0 }
end)
vim.keymap.set("n", "<leader>g", function()
  toggle_terminal({ cmd = "lazygit", state = 1 })
end)

vim.keymap.set("n", "<leader>vi", function()
  local absolute_path = vim.fn.expand('%')
  local command = "!kitty --hold kitten icat " .. absolute_path
  vim.api.nvim_command(command)
  -- toggle_terminal({ cmd = command, state = 0 })
end)

