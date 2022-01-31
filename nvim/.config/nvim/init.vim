lua require('options')
lua require('plugins')
lua require('mappings')

let g:doge_doc_standard_python = 'google'

" inoremap <C-k> <esc>:m .-2<CR>==
" inoremap <C-j> <esc>:m .+1<CR>==

lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})
EOF
