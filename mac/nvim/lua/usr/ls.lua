local ls = require('luasnip')
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
    },
})

-- require("luasnip.loaders.from_vscode").lazy_load()


--
--
-- ls.add_snippets("python", snippets)
--
-- ls.filetype_extend(
--     "javascript", { "html" },
--     "python", { "py" }
-- )
