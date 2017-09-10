--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

-- Send player pos to server
function sendPos()

  Citizen.CreateThread(function()

    while true do

      Citizen.Wait(60000 * Settings.sendPos or 1)

      local data = Player:PlayerPos()
      Player:LocalSetPlayer(data)
      TriggerServerEvent("ft_base:LocalSetPlayer", data)

    end

  end)

end

-- Save player pos in bdd
function savePos()

  Citizen.CreateThread(function()

    while true do

      Citizen.Wait(60000 * Settings.savePos or 10)

      local data = Player:PlayerPos()
      Player:Save(data)
      TriggerServerEvent("ft_base:debug", "Save player")

    end

  end)


end

-- Spawn Player
RegisterNetEvent("ft_base:PlayerReadyToJoin")
AddEventHandler('ft_base:PlayerReadyToJoin', function()

  local spawn = {
    x = Player.posX or Settings.defaultSpawn.posX or 0.0,
    y = Player.posY or Settings.defaultSpawn.posY or 0.0,
    z = Player.posZ or Settings.defaultSpawn.posZ or 0.0,
    heading = Player.heading or Settings.defaultSpawn.heading or 0,
    model = Player.model or Settings.defaultSpawn.model or "a_m_y_skater_01",
  }

  if spawn.x ~= 0 and spawn.x ~= nil and spawn.y ~= 0 and spawn.y ~= nil and spawn.z ~= 0 and spawn.z ~= nil then

    exports.spawnmanager:spawnPlayer(spawn)

    if spawn.model == "mp_m_freemode_01" or spawn.model == "mp_f_freemode_01" then
      local ped = GetPlayerPed(-1)
      SetPedDefaultComponentVariation(ped)
      SetPedComponentVariation(ped, 2, 0, 0, 0)
    end

  else

    exports.spawnmanager:spawnPlayer()

  end

  sendPos() -- send pos for playerDrop
  savePos() -- save pos in bd

end)
