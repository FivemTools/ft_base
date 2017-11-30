--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local vehicle = 0

function GetCurrentTargetCar()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)

    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
    local rayHandle = Citizen.InvokeNative(0x28579D1B8F8AAC80, coords.x, coords.y, coords.z, entityWorld.x, entityWorld.y, entityWorld.z, 10.0, 2, ped, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

    return vehicleHandle
end

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(0)

    if IsControlJustPressed(1, 303) then

      local vehcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
      local veh = GetCurrentTargetCar()

      if vehcar ~= 0 then
        local plate = GetVehicleNumberPlateText(vehcar)
        TriggerServerEvent("ft_base:LockStatus", vehcar, plate)
      elseif veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        TriggerServerEvent("ft_base:LockStatus", veh, plate)
      end

    end

    -- Exit vehicle
    -- if IsControlJustPressed(0, 75) or IsControlJustPressed(27, 75) then
    --   local vehcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    --   if vehcar ~= 0 then
    --     local plate = GetVehicleNumberPlateText(vehcar)
    --     local lockStatus = GetVehicleDoorLockStatus(vehcar)
    --     if lockStatus == 2 then
    --       DisableControlAction(0, 75, true) -- disable exit vehicle
    --       DisableControlAction(27, 75, true) -- disable exit vehicle
    --     end
    --   end
    -- end

  end

end)

RegisterNetEvent('ft_base:LockStatus')
AddEventHandler('ft_base:LockStatus', function(vehicle)
  if vehicle ~= 0 then
    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    if lockStatus == 1 or lockStatus == 0 then
      SetVehicleDoorsLocked(vehicle, 4)
      Notification("Véhicule verrouiller")
    else
      SetVehicleDoorsLocked(vehicle, 0)
      Notification("Véhicule déverrouiller")
    end
  end
end)

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(0)

    if IsControlJustPressed(1, 56) then

      TriggerServerEvent("ft_base:SpawnTest")

    end

    if IsControlJustPressed(1, 57) then
    	local ped = GetPlayerPed(-1)
    	if IsPedInAnyVehicle(ped, false) then

    		local vehicle = GetVehiclePedIsIn(ped, true)
    		local netID = VehToNet(vehicle)
    		local entityFromNetID = NetToEnt(netID)

        TriggerServerEvent("ft_base:TestWarning", netID)

    	end
    end

  end

end)

RegisterNetEvent('ft_base:SpawnTest')
AddEventHandler('ft_base:SpawnTest', function()

  if NetworkIsHost() then
      local model = GetHashKey("kuruma")
      RequestModel(model)
      while not HasModelLoaded(model) do
        Citizen.Wait(0)
      end

      local vehicle = CreateVehicle(model, 232.32, -792.26, 30.59, 336.36, true, true)
      SetModelAsNoLongerNeeded(model)
      SetVehicleOnGroundProperly(vehicle)
      local veh = NetToEnt(netID)
      SetEntityAsMissionEntity(vehicle, true, true)
      SetVehicleHasBeenOwnedByPlayer(GetPlayerPed(-1), true)

      local netID = VehToNet(vehicle)
      SetNetworkIdCanMigrate(netID, true)
      Citizen.InvokeNative(0x06FAACD625D80CAA, netID)
      SetNetworkIdExistsOnAllMachines(vehicle, true)

      for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
          Citizen.InvokeNative(0xA8A024587329F36A, netID, i, true)
        end
      end

  end

end)

RegisterNetEvent('ft_base:TestWarning')
AddEventHandler('ft_base:TestWarning', function(netID)

  if NetworkIsHost() then

    local veh = NetToEnt(netID)
    SetVehicleIndicatorLights(veh, 1, 1)

  end


end)
