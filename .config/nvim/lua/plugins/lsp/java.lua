local home = os.getenv("HOME")
local jdtls = require("jdtls")
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/dev/java" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })

  local opts = { buffer = bufnr }
  local map = require("util").map
  map("n", "<leader>cF", jdtls.organize_imports, "Organize imports <Java>", opts)
  map("n", "<leader>ct", jdtls.test_class, "Test class (DAP) <Java>", opts)
  map("n", "<leader>cT", jdtls.test_nearest_method, "Test method (DAP) <Java>", opts)
  map("n", "<leader>cev", jdtls.extract_variable, "Extract variable <Java>", opts)
  map("n", "<leader>cec", jdtls.extract_constant, "Extract constant <Java>", opts)
  map("v", "<leader>cem", jdtls.extract_method({true}), "Extract method <Java>", opts)
end

local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adaptercom.microsoft.java.debug.plugin-*.jar"),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar"), "\n"))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    bundles = bundles,
  },
  root_dir = root_dir,
  settings = {
    java = {
      -- format = {
      -- 	settings = {
      -- 		url = "/.local/share/eclipse/eclipse-java-google-style.xml",
      -- 		profile = "GoogleStyle",
      -- 	},
      -- },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
          },
        },
      },
    },
  },
  cmd = { "jdtls", workspace_folder },
  -- cmd = {
  -- 	"/usr/lib/jvm/java-21-openjdk/bin/java",
  -- 	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
  -- 	"-Dosgi.bundles.defaultStartLevel=4",
  -- 	"-Declipse.product=org.eclipse.jdt.ls.core.product",
  -- 	"-Dlog.protocol=true",
  -- 	"-Dlog.level=ALL",
  -- 	"-Xmx4g",
  -- 	"--add-modules=ALL-SYSTEM",
  -- 	"--add-opens",
  -- 	"java.base/java.util=ALL-UNNAMED",
  -- 	"--add-opens",
  -- 	"java.base/java.lang=ALL-UNNAMED",
  -- 	"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
  -- 	"-jar",
  -- 	vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
  -- 	"-configuration",
  -- 	home .. "/.local/share/nvim/mason/packages/jdtls/config_linux/config.ini",
  -- 	"-data",
  -- 	workspace_folder,
  -- },
}

local M = {}
function M.make_jdtls_config()
  return config
end

return M
