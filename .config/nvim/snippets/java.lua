local ls = require "luasnip"
local extras = require("luasnip.extras")

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local fmts = ls.extend_decorator.apply(fmt, { delimiters = "[]" })

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node
local l = extras.lambda
local ld = extras.dynamic_lambda

local function create_package()
  return f(function()
    local core = require "coredor"

    local file_dir = core.current_working_file_dir()
    local splitted = core.string_split(file_dir, "/java/")
    local package_dir = splitted[#splitted]
    if not package_dir then
      return ""
    end

    return string.gsub(package_dir, "/", ".")
  end)
end

return {
  -- s(
  --     "package",
  --     fmt("package {};", {
  --         create_package(),
  --     })
  -- ),
  s(
    "mockvernmi",
    fmt("Mockito.verifyNoMoreInteractions({});", {
      i(0, "mock"),
    })
  ),
  s(
    "mockverni",
    fmt("Mockito.verifyNoInteractions({});", {
      i(0, "mock"),
    })
  ),
  s(
    "mockret",
    fmt("Mockito.doReturn({}).when({}).{};", {
      i(0, "value"),
      i(1, "mock"),
      i(2, "method"),
    })
  ),
  s(
    "mockthr",
    fmt("Mockito.doThrow({}).when({}).{};", {
      i(0, "exception"),
      i(1, "mock"),
      i(2, "method"),
    })
  ),
  s(
    "mockvero",
    fmt("Mockito.verify({}, Mockito.only()).{};", {
      i(1, "mock"),
      i(0, "method"),
    })
  ),
  s(
    "mockver",
    fmt("Mockito.verify({}).{};", {
      i(1, "mock"),
      i(0, "method"),
    })
  ),
  s(
    "assjc",
    fmt("AssertionsForClassTypes.assertThat({}).isNotNull();", {
      i(0, "actual"),
    })
  ),
  s(
    "assji",
    fmt("AssertionsForInterfaceTypes.assertThat({}).isNotNull();", {
      i(0, "actual"),
    })
  ),
  s(
    "assjnthr",
    fmt(
      "AssertionsForClassTypes.assertThatNoException().isThrownBy(() -> {});",
      {
        i(0, "callable"),
      }
    )
  ),
  s(
    "assjthr",
    fmt("AssertionsForClassTypes.assertThatThrownBy(() -> {});", {
      i(0, "callable"),
    })
  ),
  s(
    "assa",
    fmt('Assertions.assertAll("{}", () -> {});', {
      i(1, "header"),
      i(0, "assertion"),
    })
  ),
  s(
    "assnn",
    fmt('Assertions.assertNotNull({}, "{}");', {
      i(1, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "assn",
    fmt('Assertions.assertNull({}, "{}");', {
      i(1, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "assf",
    fmt('Assertions.assertFalse({}, "{}");', {
      i(1, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "asst",
    fmt('Assertions.assertTrue({}, "{}");', {
      i(1, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "asse",
    fmt('Assertions.assertEquals({}, {}, "{}");', {
      i(1, "expected"),
      i(2, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "asss",
    fmt('Assertions.assertSame({}, {}, "{}");', {
      i(1, "expected"),
      i(2, "actual"),
      i(0, "message"),
    })
  ),
  s(
    "assthr",
    fmt('Assertions.assertThrows({}, () -> {}, "{}");', {
      i(1, "exception"),
      i(2, "throwing"),
      i(0, "message"),
    })
  ),
  s(
    "assnthr",
    fmt('Assertions.assertDoesNotThrow(() -> {}, "{}");', {
      i(1, "not throwing"),
      i(0, "message"),
    })
  ),
  s(
    "svrc",
    fmt('StepVerifier.create({}){}.verifyComplete();', {
      i(1, "actual"),
      i(0, ""),
    })
  ),
  s(
    "proplistener",
    fmts("(property, oldValue, newValue) -> {[]}", {
      i(1, ""),
    })
  ),
  s("tr1", {
    i(1, "initial text"),
    t({ "", "" }),
    -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
    -- This list will be applied in order to the first node given in the second argument.
    l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
  }),
  s("tr2", {
    i(1, "initial text"),
    t("::"),
    i(2, "replacement for e"),
    t({ "", "" }),
    -- Lambdas can also apply transforms USING the text of other nodes:
    l(l._1:gsub("e", l._2), { 1, 2 }),
  }),
  s(
  "getsetprop",
  fmts([[
  public [type]Property [var]Property() {
    return [var];
  }

  public [type] get[varNorm]() {
    return [var].get();
  }

  public void set[varNorm]([type] [var]) {
    this.[var].set([var]);
  }
  ]], {
    type = i(1, "type"),
    var = i(2, "var"),
    varNorm = l(l._2:sub(1, 1):upper() .. l._2:sub(2), {1, 2}),
    -- propType = i(3, "propType"),
  }, {
    repeat_duplicates = true,
  })),
  s(
  "getobslist",
  fmts([[
  public Observable[type] [var]Property() {
    return [var];
  }

  public [type] get[varNorm]() {
    return [var];
  }
  ]], {
    type = i(1, "type"),
    var = i(2, "var"),
    varNorm = l(l._2:sub(1, 1):upper() .. l._2:sub(2), {1, 2}),
    -- propType = i(3, "propType"),
  }, {
    repeat_duplicates = true,
  })),
}
