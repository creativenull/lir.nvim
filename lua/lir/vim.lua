-----------------------------
-- Private
-----------------------------
local lir_vim = {}

local function get_or_empty(bufnr)
  if not lir_vim[bufnr] then
    lir_vim[bufnr] = {}
  end
  return lir_vim[bufnr]
end

-----------------------------
-- Export
-----------------------------
local Vim = {}
Vim = setmetatable({}, {
  __index = function(t, key)
    local bufnr
    if type(key) == 'number' then
      -- lvim[12]
      bufnr = key
      return get_or_empty(bufnr)
    else
      -- lvim.dir
      bufnr = vim.fn.bufnr()
      return get_or_empty(bufnr)[key]
    end

  end,
})

function Vim.get_context(bufnr)
  local bufnr = bufnr or vim.fn.bufnr()
  return get_or_empty(bufnr).context
end

function Vim.set_context(context, bufnr)
  local bufnr = bufnr or vim.fn.bufnr()
  get_or_empty(bufnr).context = context
end

function Vim.print()
  pprint(lir_vim)
end

return Vim