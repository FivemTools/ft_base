--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Constructor
function Blip(data)

  local self = {}
  self.blip = nil
  self.x = data.x or 0
  self.y = data.y or 0
  self.z = data.z or 0
  self.text = data.text or "Blip"
  self.imageId = data.imageId or 416
  self.colorId = data.colorId or 0
  self.shortRange = data.shortRange or true
  self.scale = data.scale or 1.0
  self.enable = enable or true

  self.Show = function()
    Citizen.CreateThread(function()

      if self.x ~= nil and self.y ~= nil and self.z ~= nil and self.blip == nil then
        self.blip = AddBlipForCoord(self.x, self.y, self.z)
        SetBlipSprite(self.blip, self.imageId)
        SetBlipAsShortRange(self.blip, self.shortRange)
        SetBlipColour(self.blip, self.colorId)
        SetBlipScale(self.blip, self.scale)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(self.text)
        EndTextCommandSetBlipName(self.blip)
      end

    end)
  end

  self.Hide = function()
    Citizen.CreateThread(function()

      if self.blip ~= nil then
        RemoveBlip(self.blip)
      end

    end)
  end

  return self

end
