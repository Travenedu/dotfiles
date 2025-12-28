local M = {}

M.servers = {
  bashls = {
    filetypes = { "sh", "bash", "zsh" },
  },
  marksman = {},
  clangd = {
    capabilities = { offsetEncoding = { "utf-16" } },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false },
        hint = { enable = true },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = { unusedparams = true },
        staticcheck = true,
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  },
}

-- Tools for Mason to install that aren't LSPs (Formatters/Linters)
M.ensure_installed = {
  "stylua",
  "prettierd",
  "clang-format",
  "markdownlint",
  "markdownlint-cli2",
  "mdformat",
  "goimports",
  "golangci-lint",
}

return M
