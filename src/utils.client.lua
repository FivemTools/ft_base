--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

function TableLength(T)

  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count

end

-- Round number
function Round(num, numDecimalPlaces)

  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult

end

-- Comat numbere
function CommaValue(amount, delimiter)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1' .. delimiter .. '%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- Get entity
function GetEntityDirection(range)

  local playerPed = GetPlayerPed(-1)
  local pos = GetEntityCoords(playerPed)

  local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, range, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, playerPed, 0)
  local a, b, c, d, entity = GetRaycastResult(rayHandle)

  return entity

end
