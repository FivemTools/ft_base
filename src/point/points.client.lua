--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

Points = {}

function AddPoint(...)

  local args = {...}
  local count = #args
  local array = {}

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do

      Points[name] = #value.locations

      for key, location in pairs(value.locations) do
        Citizen.Wait(1)
        value.x = location.x
        value.y = location.y
        value.z = location.z
        Point(name .. "_" .. key, value)
      end

    end

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    Points[name] = #value.locations

    for key, location in pairs(value.locations) do
      Citizen.Wait(1)
      value.x = location.x
      value.y = location.y
      value.z = location.z
      Point(name .. "_" .. key, value)
    end

  else

    return false

  end

end

function RemovePoint(...)

  local args = {...}
  local count = #args
  local array = {}

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do

      Points[name] = #value.locations

      for key, location in pairs(value.locations) do
        Points[name .. "_" .. key].Remove()
      end

    end

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    Points[name] = #value.locations

    for key, location in pairs(value.locations) do
      Points[name .. "_" .. key].Remove()
    end

  else

    return false

  end

end

function EnablePoint(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      if Points[name] ~= nil then
        Points[name].Enable()
      end
    end

  elseif count == 2 then

    local name = args[1]
    local status = args[2]
    if Points[name] ~= nil then
      Points[name].Enable()
    end

  else

    return false

  end

end

function DisablePoint(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      if Points[name] ~= nil then
        Points[name].Disable()
      end
    end

  elseif count == 2 then

    local name = args[1]
    local status = args[2]
    if Points[name] ~= nil then
      Points[name].Disable()
    end

  else

    return false

  end

end

-- Events --
RegisterNetEvent('ft_base:AddPoint')
AddEventHandler('ft_base:AddPoint', AddPoint)

RegisterNetEvent('ft_base:RemovePoint')
AddEventHandler('ft_base:RemovePoint', RemovePoint)

RegisterNetEvent('ft_base:EnablePoint')
AddEventHandler('ft_base:EnablePoint', EnablePoint)

RegisterNetEvent('ft_base:DisablePoint')
AddEventHandler('ft_base:DisablePoint', DisablePoint)
