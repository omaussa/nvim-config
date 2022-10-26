local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup_format,
      buffer = 0,
      callback = function () vim.lsp.buf.formatting_seq_sync() end
    })
    vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
  end
end

local sources = {
  null_ls.builtins.diagnostics.eslint_d.with({
    diagnostics_format = '[eslint] #{m}\n(#{c})',
    condition = function(utils)
      --return utils.root_has_file({'.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json'})
      return utils.root_has_file({'node_modules/.bin/eslint'})
    end
  }),
  null_ls.builtins.diagnostics.zsh,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports_reviser,
}

null_ls.setup({
  sources = sources,
  on_attach = on_attach
})
