local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")

local symbols_to_items = function(symbols, bufnr)
    local function _symbols_to_items(_symbols, _items, _bufnr)
        for _, symbol in ipairs(_symbols) do
            if symbol.location then
                local range = symbol.location.range
                local kind = vim.lsp.util._get_symbol_kind_name(symbol.kind)
                table.insert(_items, {
                    filename = vim.uri_to_fname(symbol.location.uri),
                    lnum = range.start.line + 1,
                    col = range.start.character + 1,
                    kind = kind,
                    text = '[' .. kind .. '] ' .. symbol.name,
                })
            elseif symbol.selectionRange then
                local kind = vim.lsp.util._get_symbol_kind_name(symbol.kind)
                table.insert(_items, {
                    filename = vim.api.nvim_buf_get_name(_bufnr),
                    lnum = symbol.selectionRange.start.line + 1,
                    col = symbol.selectionRange.start.character + 1,
                    kind = kind,
                    text = '[' .. kind .. '] ' .. symbol.name,
                })
            end
        end
        return _items
    end
    return _symbols_to_items(symbols, {}, bufnr or 0)
end

local file_structure = function(opts)
    local params = vim.lsp.util.make_position_params(opts.winnr)
    vim.lsp.buf_request(opts.bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding document symbols: " .. err.message)
            return
        end

        if not result or vim.tbl_isempty(result) then
            return
        end

        local locations = symbols_to_items(result or {}, opts.bufnr) or {}
        if locations == nil then
            return
        end

        if vim.tbl_isempty(locations) then
            return
        end

        opts.path_display = { "hidden" }
        pickers
            .new(opts, {
                prompt_title = "File structure",
                finder = finders.new_table {
                    results = locations,
                    entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
                },
                previewer = conf.qflist_previewer(opts),
                push_cursor_on_edit = true,
                push_tagstack_on_edit = true,
            })
            :find()
    end)
end

return require("telescope").register_extension({
    exports = { ["file_structure"] = file_structure },
})
