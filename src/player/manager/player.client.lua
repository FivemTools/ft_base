--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

--
-- Class
--

Player = {}

-- Get player atributs
Player.Get = function(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    local table = {}
    for _, name in pairs(args[1]) do
      table[name] = Player[name]
    end
    return table

  elseif count == 1 then

    local name = args[1]
    return Player[name]

  else

    return false

  end

end

-- Set player atributs
Player.SetLocal = function(...)

  local args = {...}
  local count = #args
  local update = {}

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      Player[name] = value
      update[name] = value
    end

    return update

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    Player[name] = value
    update[name] = value

    return update

  else

    return false

  end

end

-- Set player data
Player.Set = function(...)

  local update = Player.SetLocal(...)

  if update ~= false and update ~= nil then
    TriggerServerEvent('ft_base:SetPlayer', update)
  end

end

-- Save data in Database
Player.Save = function(...)

  local args = {...}
  local count = #args
  local update = {}

  if count == 1 and type(args[1]) == "table" then

    for _, name in pairs(args[1]) do
      update[name] = Player[name]
    end

  elseif count == 1 then

    local name = args[1]
    update[name] = Player[name]

  else

    return false

  end

  -- Send to server
  if update ~= nil then
    TriggerServerEvent('ft_base:SetPlayer', update)
  end

end

-- Get Palyer pos
Player.Pos = function()

  local player = GetPlayerPed(-1)
  local pos = GetEntityCoords(player, true)
  local heading = GetEntityHeading(player)

  local data = {
    pos_x = pos.x,
    pos_y = pos.y,
    pos_z = pos.z,
    heading = heading,
  }

  return data

end

-- Add method to player class
function AddPlayerMethod(name, method)
  Player[name] = method
end

-- Return player
function GetPlayer()
  return Player
end

-- Player Methods for export
function PlayerCall(method, ...)

  local args = {...}
  local count = #args

  if count >= 1 then

    local callback = Player[method]

    if callback == nil then
      Citizen.Trace("[Player] method : " ..method .. " no exist")
      return false
    end

    return callback(Player, ...)

  end

  return false

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

  Player.Set(data)

end)

-- Update Local Player
RegisterNetEvent("ft_base:SetLocalPlayer")
AddEventHandler('ft_base:SetLocalPlayer', function(data)

  local source = source
  local data = data
  if source == -1 then
    print("Server only")
  end

  Player.SetLocal(data)

end)

-- Init client
RegisterNetEvent("ft_base:InitPlayer")
AddEventHandler('ft_base:InitPlayer', function(data)

  for name, value in pairs(data) do
    if type(value) ~= "table" then
      Player[name] = value
    end
  end

end)
