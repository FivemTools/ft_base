--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

Players = {}

--
-- Functions
--

-- Check if is in the list player
function PlayerExist(source)

  if type(Players[source]) == "nil" then
    return false
  else
    return true
  end

end

-- Add Plays in player list
function AddPlayer(source, player)
  Players[source] = player
end

-- Remove Plays in player list
function RemovePlayer(source)
  Players[source] = nil
end

-- Get All player
function GetPlayers()
  return Players
end

-- Get Identifier
function GetIdentifier(source)

  local identifiers = GetPlayerIdentifiers(source)

  if Settings.identifier == "steamId" then
    return identifiers[1]
  elseif Settings.identifier == "ip" then
    return identifiers[2]
  else
    return false
  end

end

-- Get player by identifier
function GetPlayerFromIdentifier(identifier)

  local player = nil
  local data = MySQL.Sync.fetchAll("SELECT * FROM players WHERE identifier = @identifier", { ['@identifier'] = identifier })

  if data[1] ~= nil then
    player = setmetatable(data[1], Player)
  end

  return player

end

-- Get player by id
function GetPlayerFromId(id)

  local player = nil
  local data = MySQL.Sync.fetchAll("SELECT * FROM players WHERE id = @id", { ['@id'] = id })

  if data[1] ~= nil then
    player = setmetatable(data[1], Player)
  end

  return player

end

-- Create player in database
function CreatePlayer(identifier)

  local date = os.date("%Y-%m-%d %X")
  local result = MySQL.Sync.execute("INSERT INTO players (`identifier`, `createdAt`) VALUES (@identifier, @date)", { ['@identifier'] = identifier, ['@date'] = date } )
  return result

end

--
-- Events
--

-- Update Player
RegisterServerEvent("ft_base:updatePlayer")
AddEventHandler('ft_base:updatePlayer', function(data)

  local source = source
  if source == -1 then
    print("Client only")
  end

  local player = Players[source]
  player:Set(data)

end)

-- Event is emited after client is 100% loaded games
RegisterServerEvent("ft_base:onClientReady")
AddEventHandler('ft_base:onClientReady', function()

  local source = source
  local player = {}

  if not PlayerExist(source) then

    local identifier = GetIdentifier(source)
    player = GetPlayerFromIdentifier(identifier)
    if type(player) == "nil" then
      CreatePlayer(identifier) -- Create player in db
      player = GetPlayerFromIdentifier(identifier) -- Select player in db
    end

    AddPlayer(source, player)

  else

    player = Players[source]

  end

  -- Send to client
  TriggerClientEvent("ft_base:initPlayer", source, player)

  -- Send playerReadyToJoin event
  TriggerClientEvent("ft_base:playerReadyToJoin", source)
  TriggerEvent("ft_base:playerReadyToJoin", source)

end)
