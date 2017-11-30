--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--
--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local function GetWhere(self, where)

  self.str_where = ""
  self.number_where = 0

  for name, value in pairs(where) do

    if self.number_where ~= 0 then
      self.str_where = self.str_where .. self.operator
    end

    self.str_where = self.str_where .. tostring(name) .. " = @" .. tostring(name)
    self.secure["@" .. tostring(name)] = value
    self.number_where = self.number_where + 1

  end

end

-- Table, Where, Operator
function DeleteSQL(...)

  local args = {...} -- Get all arguments
  local count = #args -- Count number arguments
  local self = {}
  self.secure = {}

  -- Operator
  self.operator = " AND "
  if count == 3 then
    self.operator = args[3]
  end

  -- Table, Where
  if count == 2 and type(args[2]) == "table" then

    local table = args[1]
    local where = args[2]

    GetWhere(self, where)

    if self.number_where >= 1 then
      MySQL.Sync.execute("DELETE FROM " .. table .. " WHERE " .. self.str_where, self.secure)
    else
      return false
    end

  else

    return false

  end

end
