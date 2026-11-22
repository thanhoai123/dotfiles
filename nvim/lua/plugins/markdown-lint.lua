-- Tat cac canh bao "phong cach" cua markdownlint (do dai dong, bang, dong trong...)
-- Cac luat bi tat nam trong ~/.markdownlint-cli2.yaml
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", vim.fn.expand("~/.markdownlint-cli2.yaml") },
      },
    },
  },
}
