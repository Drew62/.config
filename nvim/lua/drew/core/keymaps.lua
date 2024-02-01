-- set leader key to space
vim.g.mapleader = " "

local km = vim.keymap

-- Escape insert mode by typing j and k 
km.set("i", "jk", "<ESC>")

-- Clear search highlight
km.set("n", "<leader>nh", ":nohl<CR>")

-- Delete a character but dont add to register
km.set("n", "x", '"_x')

-- Increment/Decrement Numbers
km.set("n", "<leader>+", "<C-a>")
km.set("n", "<leader>-", "<C-x>")

-- Window operations
km.set("n", "<leader>sv", "<C-w>v") -- Split window vertically
km.set("n", "<leader>sh", "<C-w>s") -- Split window horizontally
km.set("n", "<leader>se", "<C-w>")  -- Make split windows eqaul width
km.set("n", "<leader>sx", ":close<CR>")  -- clore current window

-- Tab managament
km.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
km.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
km.set("n", "<leader>tn", ":tabn<CR>") -- goto next tab
km.set("n", "<leader>tp", ":tabp<CR>") -- goto prev tab
