-- bootstrap sui.nvim, LazyVim and your plugins
require("config.sui")
-- next / previous buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

-- jump to buffer by position (1–9)
for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", ":b" .. i .. "<CR>", { silent = true })
end

---------------------MODIFIED SHIT HERE------------------------------------------
vim.keymap.set("n", "<F5>", function()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local file_no_ext = vim.fn.expand("%:r")

  local cmd_map = {
    cpp = "g++ " .. file .. " -o " .. file_no_ext .. " && ./" .. file_no_ext,
    c = "gcc " .. file .. " -o " .. file_no_ext .. " && ./" .. file_no_ext,
    python = "python3 " .. file,
    javascript = "node " .. file,
    java = "javac " .. file .. " && java " .. file_no_ext,
    sh = "bash " .. file,

    haskell = "runghc " .. file,

    lisp = "sbcl --script " .. file,
  }

  local cmd = cmd_map[ft]

  if cmd then
    vim.cmd("split | terminal " .. cmd)
  else
    print("No run command for filetype: " .. ft)
  end
end, { noremap = true, silent = true })

vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]])
