--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local wantedLevel = false
local prevWantedLevel = 0
local playerWantedLevel = 0
local player = 0

AddEventHandler('ft_base:PlayerReadyToJoin', function()
  player = PlayerId()
end)

-- Remove wanted level
local function ClearWanted()
  if wantedLevel then
    SetPlayerWantedLevel(player, 0, false)
    SetPlayerWantedLevelNow(player, false)
  end
end

function DisableWantedLevel(status)
  wantedLevel = status
end

AddActionInFrames(function()

  playerWantedLevel = GetPlayerWantedLevel(player)

  if playerWantedLevel ~= prevWantedLevel then

    if prevWantedLevel == 0 and playerWantedLevel > 0 then
      TriggerEvent("ft_base:onPlayerStartWanted", playerWantedLevel)
      ClearWanted()
    elseif playerWantedLevel > prevWantedLevel then
      TriggerEvent("ft_base:onPlayerChangeWanted", playerWantedLevel)
      ClearWanted()
    elseif prevWantedLevel > 0 and playerWantedLevel == 0 then
      TriggerEvent("ft_base:onPlayerStopWanted", prevWantedLevel)
    end

  elseif playerWantedLevel > 0 then
    ClearWanted()
  end

  prevWantedLevel = playerWantedLevel

end)
