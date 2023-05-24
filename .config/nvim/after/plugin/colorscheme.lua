vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_comments = false

local colorscheme = "catppuccin"

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

