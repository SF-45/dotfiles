--=================================================================================================
--Автоматически выделяет другие экземпляры слова под курсором
--https://github.com/RRethy/vim-illuminate
--=================================================================================================
return {
  "RRethy/vim-illuminate",
  config = function()
    local map = require("util").map
    local illum = require("illuminate")
    map("n", "]]", illum.goto_next_reference, "Next Reference <Illuminate>")
    map("n", "[[", illum.goto_prev_reference, "Prev Reference <Illuminate>")
  end
}
