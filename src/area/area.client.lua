--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--
-- Constructor
function Area(data)

  local self = {}
  self.x = data.x or 0.0
  self.y = data.y or 0.0
  self.z = data.z or 0.0
  self.enable = data.enable or false
  self.weight = data.weight or 2.0
  self.height = data.height or 2.0
  self.enter = data.enter or {}
  self.exit = data.exit or {}
  self.active = data.active or {}
  self.data = data.data or {}

  self.Enter = function()
    Citizen.CreateThread(function()
      
      if self.enter.callback ~= nil then
        local callback = self.enter.callback
        callback(self.data)
      end

      if self.enter.eventClient ~= nil then
        TriggerEvent(self.enter.eventClient, self.data)
      end

      if self.enter.eventServer ~= nil then
        TriggerServerEvent(self.enter.eventServer, self.data)
      end

    end)
  end

  self.Active = function()
    Citizen.CreateThread(function()

      if self.active.callback ~= nil then
        local callback = self.active.callback
        callback(self.data)
      end

      if self.active.eventClient ~= nil then
        TriggerEvent(self.active.eventClient, self.data)
      end

      if self.active.eventServer ~= nil then
        TriggerServerEvent(self.active.eventServer, self.data)
      end

    end)
  end

  self.Exit = function()
    Citizen.CreateThread(function()

      if self.exit.callback ~= nil then
        local callback = self.exit.callback
        callback(self.data)
      end

      if self.exit.eventClient ~= nil then
        TriggerEvent(self.exit.eventClient, self.data)
      end

      if self.exit.eventServer ~= nil then
        TriggerServerEvent(self.exit.eventServer, self.data)
      end

    end)
  end

  return self

end
