return {
  'ajbucci/ipynb.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    -- Optional inline image rendering for notebook outputs.
    'folke/snacks.nvim',
  },
  config = function(_, opts)
    require('ipynb').setup(opts)

    local ok_parsers, parsers = pcall(require, 'nvim-treesitter.parsers')
    if ok_parsers then
      local parser_dir = require('ipynb.util').get_plugin_root() .. '/tree-sitter-ipynb'
      parsers.get_parser_configs().ipynb = {
        install_info = {
          url = parser_dir,
          files = { 'src/parser.c', 'src/scanner.c' },
        },
        filetype = 'ipynb',
      }
    end

    local ipynb_io = require 'ipynb.io'
    local read_ipynb = ipynb_io.read_ipynb

    -- ipynb.nvim creates a new notebook only when the file does not exist.
    -- Treat 0-byte .ipynb files the same way; otherwise vim.json.decode fails.
    ipynb_io.read_ipynb = function(path)
      if vim.fn.filereadable(path) == 1 and vim.fn.getfsize(path) == 0 then
        return ipynb_io.create_empty_notebook()
      end

      return read_ipynb(path)
    end
  end,
}
