--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local actionsInFrames = {}

function AddActionInFrames(callback)

  table.insert(actionsInFrames, callback)

end

RegisterNetEvent("ft_base:PlayerReadyToJoin")
AddEventHandler('ft_base:PlayerReadyToJoin', function()

  while true do
    Citizen.Wait(1)

    for _, callback in pairs(actionsInFrames) do
      callback()
    end

  end

end)
