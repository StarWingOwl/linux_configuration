-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here-- Replace the visually selected text with something else, prefilled
vim.keymap.set("v", "<leader>r", function()
  -- get visual range
  local s_start = vim.api.nvim_buf_get_mark(0, "<")
  local s_end = vim.api.nvim_buf_get_mark(0, ">")
  local selected =
    table.concat(vim.api.nvim_buf_get_text(0, s_start[1] - 1, s_start[2], s_end[1] - 1, s_end[2], {}), "\n")

  -- escape slashes for the :s command
  selected = selected:gsub("/", "\\/")

  -- build substitute command with selection prefilled
  vim.cmd("'<,'>s/" .. selected .. "//g")

  -- drop cursor between the slashes for the replacement text
  vim.api.nvim_feedkeys("i", "n", false)
end, { desc = "Replace in visual selection (prefilled)" })

-- cool search and replace command from ThePrimeagen
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- saw a similar feature in Doom Emacs and got jealous
vim.keymap.set("n", "<leader>.", function()
  vim.api.nvim_feedkeys(":e ", "t", false)
end, { desc = "Edit file with path completion" })

-- telescope file browser for a proper implemention of the above jank setup
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Alternatively, using lua API
vim.keymap.set("n", "<space>fb", function()
  require("telescope").extensions.file_browser.file_browser()
end)
