--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local function GetData(self, data)

  self.str_data = ""
  self.number_data = 0

  if data == "*" then
    self.number_data = 1
    self.str_data = "*"
    return
  end

  for name, value in pairs(data) do

    if self.number_data ~= 0 then
      self.str_data = self.str_data .. ", "
    end

    self.str_data = self.str_data .. tostring(name)
    self.number_data = self.number_data + 1

  end

end

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

-- Table, Data, Where, Operator
function SelectSQL(...)

  local args = {...} -- Get all arguments
  local count = #args -- Count number arguments
  local self = {}
  self.secure = {}

  -- Operator
  self.operator = " AND "
  if count == 4 then
    self.operator = args[4]
  end

  -- Table, Data
  if count == 2 and type(args[2]) == "table" or count == 2 and args[2] == "*" then

    local table = args[1]
    local data = args[2]

    GetData(self, data)

    if self.number_data >= 1 then
      return MySQL.Sync.fetchAll("SELECT " .. self.str_data .. " FROM " .. table .. " WHERE 1", self.secure)
    else
      return false
    end

  -- Table, Data, Where
  elseif count == 3 and (type(args[2]) == "table" or args[2] == "*") and type(args[3]) == "table" then

    local table = args[1]
    local data = args[2]
    local where = args[3]

    GetData(self, data)
    GetWhere(self, where)

    if self.number_data >= 1 and self.number_where >= 1 then
      return MySQL.Sync.fetchAll("SELECT " .. self.str_data .. " FROM " .. table .. " WHERE " .. self.str_where, self.secure)
    else
      return false
    end

  else

    return false

  end

end
