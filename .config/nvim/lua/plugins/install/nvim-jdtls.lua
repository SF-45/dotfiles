--=================================================================================================
--Java LSP tools
--https://github.com/mfussenegger/nvim-jdtls
--=================================================================================================
return {
  "mfussenegger/nvim-jdtls",
  lazu = true,
  ft = "java",
  config = function()
    require("util").register_autocmd("FileType", {
      group = "java_lsp_attach",
      pattern = {
        "java",
      },
      callback = function(event)
        local config = require("plugins.lsp.java").make_jdtls_config()
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}
