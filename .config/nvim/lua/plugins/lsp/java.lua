local home = os.getenv("HOME")
local jdtls = require("jdtls")
-- local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_markers = { "gradlew", "mvnw" }
local root_dir = jdtls.setup.find_root(root_markers)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. "/dev/java/" .. project_name

local mason_share = home .. "/.local/share/nvim/mason/share"

local on_attach = function(_, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })

  local opts = { buffer = bufnr }
  local map = require("util").map
  map("n", "<leader>cF", jdtls.organize_imports, "Organize imports <Java>", opts)
  map("n", "<leader>ct", jdtls.test_class, "Test class (DAP) <Java>", opts)
  map("n", "<leader>cT", jdtls.test_nearest_method, "Test method (DAP) <Java>", opts)
  map("n", "<leader>cev", jdtls.extract_variable, "Extract variable <Java>", opts)
  map("n", "<leader>cec", jdtls.extract_constant, "Extract constant <Java>", opts)
  map("v", "<leader>cem", function() jdtls.extract_method({ true }) end, "Extract method <Java>", opts)

  if (project_name == "owlook-project") then
    map("n", "<leader>cRr", ":!./owlook.sh<CR>", "Run Owlook App <Owlook>", opts)
  end

  vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>) ]]
  vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>) ]]
  vim.cmd [[ command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config() ]]
  vim.cmd [[ command! -buffer JdtBytecode lua require('jdtls').javap() ]]
  vim.cmd [[ command! -buffer JdtJol lua require('jdtls').jol() ]]
  vim.cmd [[ command! -buffer JdtJshell lua require('jdtls').jshell() ]]
end

local bundles = {
  mason_share .. "/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
  vim.fn.glob(mason_share .. "/java_test/*.jar"),
}

-- vim.list_extend(bundles, vim.split(vim.fn.glob(mason_share .. "/java_test/*.jar", true), "\n"))

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
      format = {
        settings = {
          url = home .. "/.config/nvim/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
      compile = {
        nullAnalysis = {
          nonnull = {
            "lombok.NonNull",
            "javax.annotation.Nonnull",
            "org.eclipse.jdt.annotation.NonNull",
            "org.springframework.lang.NonNull",
          },
        },
      },
      maven = { downloadSources = true },
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
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk",
          },
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
  --cmd = { "jdtls", workspace_folder },
  -- cmd = {
  --   "jdtls",
  --   "-data",
  --   workspace_dir,
  --   "--jvm-arg=-XX:+UseParallelGC",
  --   "--jvm-arg=-XX:GCTimeRatio=4",
  --   "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
  --   "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
  --   "--jvm-arg=-Xmx1500m",
  --   "--jvm-arg=-Xms700m",
  --   "--jvm-arg=-Xlog:disable",
  --   "--jvm-arg=-javaagent:"
  --   .. get_install_path_for "jdtls"
  --   .. "/lombok.jar",
  -- },
  cmd = {
    "jdtls",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", mason_share .. "/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration", mason_share .. "/jdtls/config",
    "--jvm-arg=-javaagent:" .. mason_share .. "/jdtls/lombok.jar",
    "-data", workspace_dir
  },
}

local M = {}
function M.make_jdtls_config()
  return config
end

return M
