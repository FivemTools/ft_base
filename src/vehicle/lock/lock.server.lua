--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local VehicleDatabase = {}

---------------------Add and remove function---------------------
function AddVehicleLock(source, plate)

  local steamId = GetPlayerIdentifiers(source)[1]
  local name = GetPlayerName(source)
  table.insert(VehicleDatabase, {plate=plate, ownername=name, owner=steamId})

end

function RemoveVehicleLock(source, plate)

  local steamId = GetPlayerIdentifiers(source)[1]
  for k,vehicle in pairs(VehicleDatabase) do
    if vehicle.plate == plate and vehicle.owner == steamId then
      table.remove(VehicleDatabase, k)
      break
    end
  end

end

RegisterServerEvent("ft_base:AddVehicleLock")
AddEventHandler("ft_base:AddVehicleLock", function(networkId)

  AddVehicleLock(source, networkId)

end)

RegisterServerEvent("ft_base:RemoveVehicleLock")
AddEventHandler("ft_base:RemoveVehicleLock", function(networkId)

  RemoveVehicleLock(source, networkId)

end)

RegisterServerEvent("ft_base:LockStatus")
AddEventHandler("ft_base:LockStatus", function(plate)

  if networkId ~= false then

    local steamId = GetPlayerIdentifiers(source)[1]

    for _, vehicle in pairs(VehicleDatabase) do
      if vehicle.plate == plate then
        if vehicle.owner == steamId then
          TriggerClientEvent('ft_base:LockStatus', source, plate)
          break
        end
      end
    end

    AddVehicleLock(source, networkId)

  end

end)

RegisterServerEvent("ft_base:TestWarning")
AddEventHandler("ft_base:TestWarning", function(networkId)

  TriggerClientEvent("ft_base:TestWarning", -1, networkId)

end)

RegisterServerEvent("ft_base:SpawnTest")
AddEventHandler("ft_base:SpawnTest", function()

  TriggerClientEvent("ft_base:SpawnTest", -1)

end)
