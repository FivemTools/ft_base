--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

function DisableDispatch(data)
  Citizen.CreateThread(function()

    if type(data) == "table" then

      for _, value in ipairs(data) do
        Citizen.InvokeNative(0xDC0F817884CDD856, value, false)
      end

    else
      Citizen.InvokeNative(0xDC0F817884CDD856, data, false)
    end

  end)
end

function EnableDispatch(data)
  Citizen.CreateThread(function()

    if type(data) == "table" then

      for _, value in ipairs(data) do
        Citizen.InvokeNative(0xDC0F817884CDD856, value, true)
      end

    else
      Citizen.InvokeNative(0xDC0F817884CDD856, data, true)
    end

  end)
end


local dispatchCopsForPlayer = true
function EnableDispatchCopsForPlayer(status)
  dispatchCopsForPlayer = status
end

-- Add to frame
AddActionInFrames(function()

  local playerId = PlayerId()
  SetDispatchCopsForPlayer(playerId, dispatchCopsForPlayer)

end)
