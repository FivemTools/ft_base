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
function Player:Set(...)

  local args = {...}
  local count = #args
  local update = {}

  if count == 1 and type(args[1]) == "table" then

    for name, value in pairs(args[1]) do
      self[name] = value
      update[name] = value
    end

    TriggerServerEvent('ft_base:updatePlayer', update)

  elseif count == 2 then

    local name = args[1]
    local value = args[2]
    self[name] = value
    update[name] = value

    TriggerServerEvent('ft_base:updatePlayer', update)

  else

    return false

  end

end

--
-- Events
--

-- Client is 100% loaded games
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    if NetworkIsSessionStarted() then

      TriggerServerEvent('ft_base:onClientReady')
      TriggerEvent('ft_base:onClientReady')
      break

    end

  end
end)

-- Init client
RegisterNetEvent("ft_base:initPlayer")
AddEventHandler('ft_base:initPlayer', function(data)

  Player = setmetatable(data, Player)
  Player:Set("cash", 5000)

end)
