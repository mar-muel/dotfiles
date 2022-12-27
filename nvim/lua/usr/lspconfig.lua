local lsp = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'pyright'
})

lsp.setup_nvim_cmp({
    mapping = {
        -- from: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#intellij-like-mapping
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                if cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        cmp.confirm()
                    end
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {"i","s","c",}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"}),
        ['<CR>'] = cmp.mapping.confirm(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    }
})

lsp.set_preferences({
    -- disable sign icons
    sign_icons = {  }
})

lsp.setup()
