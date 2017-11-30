--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Send player pos to server
function sendPos()

  Citizen.CreateThread(function()

    while true do

      Citizen.Wait(60000 * (Settings.sendPos or 1))
      LoadingPromt("Envoie d'information au serveur", 5000, 4)

      local data = Player.Pos()
      Player.SetLocal(data)
      TriggerServerEvent("ft_base:SetLocalPlayer", data)

    end

  end)

end

-- Save player pos in bdd
function savePos()

  Citizen.CreateThread(function()

    while true do

      Citizen.Wait(60000 * (Settings.savePos or 10))
      LoadingPromt("Sauvegarde en cours", 5000, 4)

      Player.Save({
        "pos_x",
        "pos_y",
        "pos_z",
        "heading",
      })

    end

  end)

end

-- Spawn Player
AddEventHandler('ft_base:PlayerReadyToJoin', function()

  local spawn = {}

  if tostring(Player.pos_x) ~= tostring(0.0) and Player.pos_x ~= nil and tostring(Player.pos_y) ~= tostring(0.0) and Player.pos_y ~= nil and tostring(Player.pos_z) ~= 0.0 and Player.pos_z ~= nil then

    spawn = {
      x = Player.pos_x,
      y = Player.pos_y,
      z = Player.pos_z,
      heading = Player.heading,
      model = Player.model or "mp_m_freemode_01",
    }

  else

    spawn = {
      x = Settings.default_spawn.pos_x or 0.0,
      y = Settings.default_spawn.pos_y or 0.0,
      z = Settings.default_spawn.pos_z or 0.0,
      heading = Settings.default_spawn.heading or 0.0,
      model = "mp_m_freemode_01",
    }

  end

  exports.spawnmanager:spawnPlayer(spawn)

  if spawn.model == "mp_m_freemode_01" or spawn.model == "mp_f_freemode_01" then
    local ped = GetPlayerPed(-1)
    SetPedDefaultComponentVariation(ped)
    SetPedComponentVariation(ped, 2, 0, 0, 0)
  end

  sendPos()
  savePos()

end)
