--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local function GetQuery(self, query)

  self.str_query = ""
  self.number_query = 0

  for name, value in pairs(query) do
    if name ~= "id" then

      if self.number_query ~= 0 then
        self.str_query = self.str_query .. ", "
      end

      self.str_query = self.str_query .. tostring(name) .. " = @" .. tostring(name)
      self.secure["@" .. tostring(name)] = value
      self.number_query = self.number_query + 1

    end
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
function UpdateSQL(...)

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
  if count == 2 and type(args[2]) == "table" then

    local table = args[1]
    local query = args[2]

    GetQuery(self, query)

    if self.number_query >= 1 then
      MySQL.Sync.execute("UPDATE " .. table .. " SET " .. self.str_query, self.secure)
    else
      return false
    end

  -- Table, Data, Where
  elseif count == 3 and type(args[2]) == "table" and type(args[3]) == "table" then

    local table = args[1]
    local query = args[2]
    local where = args[3]

    GetQuery(self, query)
    GetWhere(self, where)

    if self.number_query >= 1 and self.number_where >= 1 then
      MySQL.Sync.execute("UPDATE " .. table .. " SET " .. self.str_query .. " WHERE " .. self.str_where, self.secure)
    else
      return false
    end

  else

    return false

  end

end
