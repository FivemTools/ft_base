--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

-- Print table
function tprint(tbl, indent)

  if type(tbl) == "table" then
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent + 1)
      elseif type(v) == "boolean" then
        if v then
          print(formatting .. "true")
        else
          print(formatting .. "false")
        end
      elseif type(v) == "nil" then
        print(formatting .. "nil")
      elseif type(v) == "function" then
        print(formatting .. "function")
      else
        print(formatting .. tostring(v) .. " (" .. type(v) .. ")")
      end
    end
  elseif type(tbl) == "boolean" then
    if tbl then
      print("true")
    else
      print("false")
    end
  elseif type(tbl) == "nil" then
    print("nil")
  elseif type(tbl) == "function" then
    print("function")
  else
    print(tostring(tbl))
  end

end
