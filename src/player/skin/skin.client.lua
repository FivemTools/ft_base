--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

Player.localClothing = function(data)

  local playerPed = GetPlayerPed(-1)


end

Player.loadSkin = function(data)

  local playerPed = GetPlayerPed(-1)


end

Player.localBody = function(data)

  local playerPed = GetPlayerPed(-1)


end

Player.loadHead = function(data)

  local playerPed = GetPlayerPed(-1)


end

Player.loadModel = function(data)

  local model = GetHashKey(data)
  RequestModel(model)
  while not HasModelLoaded(model) do
    RequestModel(model)
    Wait(0)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)

end
