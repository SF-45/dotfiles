vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
--
local opt = vim.opt

--Misk
opt.autowrite = false -- Автосохранение
opt.clipboard = "unnamedplus" -- Синхронизация с системным буфером обмена
opt.completeopt = "menu,menuone,noselect" -- Нативное автозавершение
opt.conceallevel = 3 -- Скрыть * сиволы для жирного и курсива
opt.confirm = true -- Подтверждение сохранения при закрытии буфера
opt.updatetime = 200 -- Раз в сколько милисекунд будет сохраняться Swap файл
opt.undofile = true -- Сохранять историю изменений в файл
opt.undolevels = 10000
opt.virtualedit = "block" -- Позваляет выставлять курсор туда, где нет никаих символов
opt.list = true -- Отображение невидимых символов
opt.termguicolors = true -- True color support
opt.showmode = false -- Dont show mode since we have a statusline
opt.spelllang = { "en_us,ru_ru" } -- Языки для проверки правописания. Для включения :se spell
opt.timeoutlen = 300 -- Задержка, после которой Nvim считает, что последовательность горячих клавиш окончена
opt.wildmode = "longest:full,full" -- Режим автозавершения для команндного режима
opt.winminwidth = 5 -- Minimum window width
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
opt.laststatus = 3 -- Одна строка состояния на все открытые окна
--Строки
opt.cursorline = true -- Enable highlighting of the current line
opt.number = true -- Print line number
opt.relativenumber = true -- Относительная нумерация строк
opt.wrap = false -- Визуальный перенос строк
opt.scrolloff = 8 -- Сколько строк должно быть видно над и под курсором при скролле
opt.sidescrolloff = 8 -- Сколько строк должно быть видно слева и справа от курсора при скролле

--Отступы
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.shiftround = true -- Round indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.smartindent = true -- Добавлять отступ при переходе на новую строку
opt.signcolumn = "yes" -- Отступ слева от номеров строк

--Форматирование текста
opt.comments = "s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:•"
opt.formatoptions = "roqn" -- Форматирование текста
--r - Вставка комментариев
--o - Вставка комментария по 'o' и 'O'
--q - Разрешиает форматирование комментариев по 'gq'
--n - Формирование списка (не работает хз почему)
opt.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]] -- Паттерн формирование списка для formatoptions = n

--Мышка
opt.mouse = "a" -- Enable mouse mode
opt.mousefocus = true
opt.mousemoveevent = true

--Fillchars
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	-- fold = "⸱",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

--Splits
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"

--Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

--Popup
opt.pumblend = 10 -- Прозрачность всплывающего окна
opt.pumheight = 10 -- Максимальное количество элементов в всплывающем окне

--opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
--opt.shortmess:append({ W = true, I = true, c = true, C = true })
--opt.smoothscroll = true
