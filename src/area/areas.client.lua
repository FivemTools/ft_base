--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

Areas = {}
Areas.current = nil

function AddArea(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      Citizen.Wait(1)
      Areas[name] = Area(value)
    end

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    Areas[name] = Area(value)

  else

    return false

  end

end

function RemoveArea(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, name in ipairs(args[1]) do
      Citizen.Wait(1)
      if Areas[name] ~= nil then
        Areas[name] = nil
      end
    end

  elseif count == 1 then

    local name = args[1]
    if Areas[name] ~= nil then
      Areas[name] = nil
    end

  else

    return false

  end

end

function EnableArea(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      Citizen.Wait(1)
      if Areas[name] ~= nil then
        Areas[name].enable = value
      end
    end

  elseif count == 2 then

    local name = args[1]
    local status = args[2]
    if Areas[name] ~= nil then
      Areas[name].enable = status
    end

  else

    return false

  end

end

function CurrentArea()
  return Areas.current
end

-- Events --

RegisterNetEvent('ft_base:AddArea')
AddEventHandler('ft_base:AddArea', AddArea)

RegisterNetEvent('ft_base:RemoveArea')
AddEventHandler('ft_base:RemoveArea', RemoveArea)

RegisterNetEvent('ft_base:EnableArea')
AddEventHandler('ft_base:EnableArea', EnableArea)

-- Check
AddActionInFrames(function()

  local playerPed = GetPlayerPed(-1)
  local playerLocalisation = GetEntityCoords(playerPed)

  for name, area in pairs(Areas) do

    if area.enable then
      player_in = (GetDistanceBetweenCoords(area.x, area.y, area.z, playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, true) < (area.weight + 0.0) and math.abs(playerLocalisation.z - area.z) <= (area.height + 0.0))

      if player_in and Areas.current ~= name then
        Areas.current = name
        area.Enter()
      elseif player_in and Areas.current == name then
        area.Active()
      elseif not player_in and Areas.current == name then
        Areas.current = nil
        area.Exit()
      end
    end

  end

end)
