--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

--
-- Class
--

Player = {}
Player.__index = Player

-- Get player atributs
function Player:Get(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    local table = {}
    for _, name in pairs(args[1]) do
      table[name] = self[name]
    end
    return table

  elseif count == 1 then

    local name = args[1]
    return self[name]

  else

    return false

  end

end

-- Set player atributs
function Player:LocalSet(...)

  local args = {...}
  local count = #args
  local update = {}

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      self[name] = value
      update[name] = value
    end

    return update

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    self[name] = value
    update[name] = value

    return update

  else

    return false

  end

end


function Player:Set(...)

  local update = self:LocalSet(...)

  if update ~= false and update ~= nil then
    TriggerServerEvent('ft_base:SetPlayer', update)
  end

end

-- Save data in Database
function Player:Save(...)

  local args = {...}
  local count = #args
  local update = {}

  if count == 1 and type(args[1]) == "table" then

    for _, name in pairs(args[1]) do
      update[name] = self[name]
    end

  elseif count == 1 then

    local name = args[1]
    update[name] = self[name]

  else

    return false

  end

  -- Send to server
  if update ~= nil then
    TriggerServerEvent('ft_base:SetPlayer', update)
  end

end

-- Get Palyer pos
function Player:PlayerPos()

  local player = GetPlayerPed(-1)
  local pos = GetEntityCoords(player, true)
  local heading = GetEntityHeading(player)

  local data = {
    posX = pos.x,
    posY = pos.y,
    posZ = pos.z,
    heading = heading,
  }

  return data

end


--
-- Events
--

-- Client is 100% loaded games
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    if NetworkIsSessionStarted() then

      TriggerServerEvent('ft_base:OnClientReady')
      TriggerEvent('ft_base:OnClientReady')
      break

    end

  end
end)

-- Update Player
RegisterNetEvent("ft_base:SetPlayer")
AddEventHandler('ft_base:SetPlayer', function(data)

  local source = source
  if source == -1 then
    print("Server only")
  end

  Player:Set(data)

end)

-- Update Local Player
RegisterNetEvent("ft_base:SetLocalPlayer")
AddEventHandler('ft_base:SetLocalPlayer', function(data)

  local source = source
  local data = data
  if source == -1 then
    print("Server only")
  end

  Player:LocalSet(data)

end)

-- Init client
RegisterNetEvent("ft_base:InitPlayer")
AddEventHandler('ft_base:InitPlayer', function(data)

  Player = setmetatable(data, Player)

end)
