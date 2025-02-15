local M = {}

--- @param table table
--- @param value string
---@return boolean
function M.table_contains(table, value)
    if table == nil then
        return false
    end
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

---@param a table
---@param b table
---@return boolean
function M.score_sort(a, b)
    return a.score > b.score
end

---@param scores_table table
---@return table
function M.top5(scores_table)
    local top_list = {}
    for i = 1, 5 do
        table.insert(top_list, scores_table[i])
    end
    return top_list
end

---@param t1 table
---@param t2 table
---@return table
function M.merge_tables(t1, t2)
    local t3 = {}

    --[[ for _, v in pairs(t1) do
        table.insert(t3, v)
    end

    for _, v in pairs(t2) do
        table.insert(t3, v)
    end
]]

    for _, v in pairs(t1) do
        table.insert(t3, v)
    end

    for _, v in pairs(t2) do
        local found = false
        for _, v2 in pairs(t3) do
            if v2.lhs == v.lhs and v.from_file == "Vim Defaults" then
                found = true
            end
        end
        if not found then
            table.insert(t3, v)
        end
    end
    return t3
end

function M.find_duplicates(keymaps)
    local duplicates = {}
    for _, v in pairs(keymaps) do
        for _, v2 in pairs(keymaps) do
            if v.lhs == v2.lhs and v.mode == v2.mode and v.rhs ~= v2.rhs then
                table.insert(duplicates, { v.lhs, { v }, { v2 } })
            end
        end
    end
    return duplicates
end

return M
