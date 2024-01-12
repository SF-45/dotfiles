--=================================================================================================
--Удаление буферов
--https://github.com/echasnovski/mini.bufremove
--=================================================================================================
local function buf_delete()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end
return {
  "echasnovski/mini.bufremove",
  config = function()
    require("mini.bufremove").setup()
    local map = require("util").map
    map("n", "<leader>bd", buf_delete, "Delete Buffer <BufRemove>")
    map("n", "<leader>qq", buf_delete, "Delete Buffer <BufRemove>")

    map("n", "<leader>bD", function()
      require("mini.bufremove").delete(0, true)
    end, "Delete Buffer (Force) <BufRemove>")
  end,
}
