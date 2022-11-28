local bind = require("utils.keymap")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

--------===[ Modes ]===--------
-- -> Normal_Mode        = "n",
-- -> Insert_Mode        = "i",
-- -> Visual_Mode        = "v",
-- -> Visual_Block_Mode  = "x",
-- -> Terminal_Mode      = "t",
-- -> Command_Mode       = "c",

local def_basics = {
    -- <Esc> -> disable highlight
    ["n|<Esc>"] = map_cr("noh"):with_noremap():with_silent(),

    -- Quicker access to `:`
    ["n|;"] = map_cmd(":"):with_noremap(),

    -- Ctrl + s -> save current buffer
    ["n|<C-s>"] = map_cu("write"):with_noremap(),

    -- Better window navigation
    ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap():with_silent(),
    ["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap():with_silent(),
    ["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap():with_silent(),
    ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap():with_silent(),

    -- Resize with arrows
    ["n|<C-Up>"] = map_cr("resize -2"):with_noremap():with_silent(),
    ["n|<C-Down>"] = map_cr("resize +2"):with_noremap():with_silent(),
    ["n|<C-Left>"] = map_cr("vertical resize -2"):with_noremap():with_silent(),
    ["n|<C-Right>"] = map_cr("vertical resize +2"):with_noremap():with_silent(),

    -- (Barbar.nvim) buffer navigation
    ["n|L"] = map_cr("BufferLineCycleNext"):with_noremap(),
    ["n|H"] = map_cr("BufferLineCyclePrev"):with_noremap(),

    -- (Barbar.nvim) Re-order buffers -> previous || next
    ["n|<A-<>"] = map_cmd("BufferLineMovePrev"):with_noremap():with_silent(),
    ["n|<A->>"] = map_cmd("BufferLineMoveNext"):with_noremap():with_silent(),

    -- (Barbar.nvim) Pin/Unpin current buffer
    ["n|<A-p>"] = map_cmd("BufferLineTogglePin"):with_noremap():with_silent(),
    ["n|<A-c>"] = map_cmd("BufferlineCloseButton"):with_noremap():with_silent(),

    -- Remap scroll -> scroll + cursor in middle of screen!
    ["n|<C-d>"] = map_cmd("<C-d>zz"):with_noremap():with_silent(),
    ["n|<C-u>"] = map_cmd("<C-u>zz"):with_noremap():with_silent(),

    -- Search and replace word under cursor
    ["n|<A-s>"] = map_cmd(":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
        :with_noremap()
        :with_silent(),

    -- Make current file executable
    ["n|<A-x>"] = map_cmd("!chmod +x %"):with_noremap():with_silent(),

    -- Paste in place of word -> move word to newline
    ["x|p"] = map_cmd('"_dP'):with_noremap(),

    -- (quick) Yank to clipboard
    ["n|<A-y>"] = map_cmd('"+y'):with_noremap():with_silent(),
    ["v|<A-y>"] = map_cmd('"+y'):with_noremap():with_silent(),
    ["n|<A-Y>"] = map_cmd('"+Y'):with_silent(),

    -- Delete without yanking
    ["n|<A-d>"] = map_cmd('"_d'):with_noremap():with_silent(),
    ["v|<A-d>"] = map_cmd('"_d'):with_noremap():with_silent(),

    -- Press jk fast to enter
    ["i|jk"] = map_cmd("<ESC>"):with_noremap(),

    -- Stay in indent mode
    ["v|<"] = map_cmd("<gv"):with_noremap(),
    ["v|>"] = map_cmd(">gv"):with_noremap(),

    -- Move text up and down
    ["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_noremap(),
    ["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_noremap(),

    -- Better terminal navigation
    ["t|<C-h>"] = map_cmd("<C-\\><C-N><C-w>h"):with_silent(),
    ["t|<C-j>"] = map_cmd("<C-\\><C-N><C-w>j"):with_silent(),
    ["t|<C-k>"] = map_cmd("<C-\\><C-N><C-w>k"):with_silent(),
    ["t|<C-l>"] = map_cmd("<C-\\><C-N><C-w>l"):with_silent(),
}

bind.nvim_load_mapping(def_basics)
