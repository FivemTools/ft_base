--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

local pedDensity = 0.5
local scenarioPedDensity = {0.0, 0.5}

local trafficDensity = 0.5
local parkedVehicleDensity = 0.5
local randomVehicleDensity = 0.5

local terminateScripts = {}

function ChangeTrafficDensity(number)
  trafficDensity = number
end

function ChangePedDensity(number)
  pedDensity = number
end

function ChangeParkedVehicleDensity(number)
  parkedVehicleDensity = number
end

-- COPS
function EnableCopsSpawn(status)
  SetCreateRandomCops(status)
  SetCreateRandomCopsOnScenarios(status)
  SetCreateRandomCopsNotOnScenarios(not status)
end

-- BOATS
function EnableBoatsSpawn(status)
  SetRandomBoats(status)
end

-- TRAINS
function DisableTrainsSpawn()
  SetRandomTrains(false)
end

-- GARBAGE TRUCKS
function EnableGarbageTrucksSpawn(status)
  SetGarbageTrucks(status)
end

-- Terminate Scripts
function AddTerminateScripts(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, value in ipairs(args[0]) do
      terminateScripts[value] = value
    end

  elseif count == 1 then
    local value = args[0]
    terminateScripts[value] = value
  end

end

function RemoveTerminateScripts(...)

  local args = {...}
  local count = #args

  if count == 1 and type(args[1]) == "table" then

    for _, value in ipairs(args[0]) do
      terminateScripts[value] = nil
    end

  elseif count == 1 then
    local value = args[0]
    terminateScripts[value] = nil
  end

end

AddActionInFrames(function()

    -- Ped
    SetPedDensityMultiplierThisFrame(pedDensity)
    SetScenarioPedDensityMultiplierThisFrame(scenarioPedDensity[0], scenarioPedDensity[1])

    -- Vehicle
    SetVehicleDensityMultiplierThisFrame(trafficDensity)
		SetRandomVehicleDensityMultiplierThisFrame(randomVehicleDensity)
    SetParkedVehicleDensityMultiplierThisFrame(parkedVehicleDensity)

    -- Terminate Scripts
    for _, value in ipairs(terminateScripts) do
      TerminateAllScriptsWithThisName(value)
    end

end)
