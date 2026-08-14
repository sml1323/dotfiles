-- Format on save and linters
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- list of formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'checkmake',
        'prettier', -- ts/js formatter
        'eslint_d', -- ts/js linter
        'shfmt',
        'sqlfluff', -- SQL linter & formatter (postgres/timescaledb)
        -- 'stylua', -- lua formatter; Already installed via Mason
        -- 'ruff', -- Python linter and formatter; Already installed via Mason
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    }

    -- sqlfluff 는 --dialect 가 필수다.
    -- layout 규칙군(LT*)은 기본으로 뺀다 — 줄 길이(한글 주석·URL), 들여쓰기,
    -- 컬럼 세로 정렬용 여러 칸 공백에 죄다 걸려서 정작 잡아야 할 문법 오류
    -- (PRS unparsable)가 잔소리에 묻힌다. 문법·구조·일관성 규칙은 그대로 살아 있다.
    -- 단, sqlfluff 는 CLI 인자가 설정 파일을 이기므로 프로젝트에 .sqlfluff 가 있으면
    -- 규칙 판단은 그쪽에 맡긴다(dialect 는 누락 대비로 항상 넘긴다).
    local function sqlfluff_args(params)
      local args = { '--dialect', 'postgres' }
      local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(params.bufnr or 0))
      if not vim.fs.find('.sqlfluff', { upward = true, path = dir })[1] then
        vim.list_extend(args, { '--exclude-rules', 'layout' })
      end
      return args
    end

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
      diagnostics.sqlfluff.with { extra_args = sqlfluff_args },
      formatting.sqlfluff.with { extra_args = sqlfluff_args },
    }

    -- 저장 시 자동 포맷에서 제외할 파일타입.
    -- sql: sqlfluff fix 가 키워드 대소문자·들여쓰기·빈 줄을 통째로 재작성해서
    --      주석 정렬이 의미를 갖는 마이그레이션 파일이 뒤집힌다.
    --      진단(린트)은 그대로 받고, 정렬이 필요할 때만 <leader>f 로 직접 부른다.
    local format_on_save_ignore = { sql = true }

    -- 수동 포맷 — 자동 포맷에서 뺀 파일타입을 원할 때만 정렬한다.
    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      vim.lsp.buf.format { async = false }
    end, { desc = '[F]ormat buffer' })

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          if not format_on_save_ignore[vim.bo[bufnr].filetype] then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end
      end,
    }
  end,
}
