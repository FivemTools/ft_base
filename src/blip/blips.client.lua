--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local Blips = {}

function AddBlip(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      Citizen.Wait(1)
      Blips[name] = Blip(value)

      if Blips[name].enable then
        Blips[name].Show()
      end
    end

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    Blips[name] = Blip(value)

    if Blips[name].enable then
      Blips[name].Show()
    end

  else

    return false

  end

end

function RemoveBlip(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, name in ipairs(args[1]) do
      Citizen.Wait(1)
      Blips[name] = nil
    end

  elseif count == 1 then

    local name = args[1]
    Blips[name] = nil

  else

    return false

  end

end

function ShowBlip(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, name in ipairs(args[1]) do
      Citizen.Wait(1)
      if Blips[name] ~= nil then
        Blips[name].Show()
      end
    end

  elseif count == 2 then

    local name = args[1]
    if Blips[name] ~= nil then
      Blips[name].Show()
    end

  else

    return false

  end

end

function HideBlip(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, name in ipairs(args[1]) do
      Citizen.Wait(1)
      if Blips[name] ~= nil then
        Blips[name].Hide()
      end
    end

  elseif count == 2 then

    local name = args[1]
    if Blips[name] ~= nil then
      Blips[name].Hide()
    end

  else

    return false

  end

end

RegisterNetEvent('ft_base:AddBlip')
AddEventHandler('ft_base:AddBlip', AddBlip)

RegisterNetEvent('ft_base:RemoveBlip')
AddEventHandler('ft_base:RemoveBlip', RemoveBlip)

RegisterNetEvent('ft_base:ShowBlip')
AddEventHandler('ft_base:ShowBlip', ShowBlip)

RegisterNetEvent('ft_base:HideBlip')
AddEventHandler('ft_base:HideBlip', HideBlip)
