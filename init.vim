call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'tomasiser/vim-code-dark'
call plug#end()

set number
syntax on
colorscheme codedark

lua << EOF

-- 启用 pyright（Python LSP）
require('lspconfig').pyright.setup({
  on_attach = function(client, bufnr)
    -- 绑定快捷键：K 查看函数文档
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    -- 绑定快捷键：<C-k> 查看函数签名
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
  end
})


-- 搭配 nvim-cmp 补全
local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },  -- LSP 补全
    { name = 'buffer' },     -- 当前缓冲区补全
    { name = 'path' },        -- 路径补全
    { name = 'nvim_lsp_signature_help'}
  }
})


-- 启用 VSCode 风格图标
require('lspkind').init({
  symbol_map = {
    Class = " ",  -- 自定义图标
    Function = " "
  }
})
-- highlight
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}


EOF
