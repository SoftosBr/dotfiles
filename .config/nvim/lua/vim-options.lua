vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.diagnostic.config({
  virtual_text = true, -- Exibe mensagens de diagnóstico inline (na linha do código)
  signs = true,        -- Exibe ícones na coluna de sinais (gutter)
  underline = true,    -- Sublinha o texto com problemas
  update_in_insert = false, -- Não atualiza diagnósticos enquanto você digita no modo de inserção (pode ser "true" se preferir feedback instantâneo)
  severity_sort = true, -- Classifica os diagnósticos por severidade (erros primeiro, depois warnings, etc.)
})

local signs = {
  Error = "", -- Ícone para erro
  Warn = "",  -- Ícone para warning
  Hint = "󰈅",  -- Ícone para hint
  Info = " "   -- Ícone para informação
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
