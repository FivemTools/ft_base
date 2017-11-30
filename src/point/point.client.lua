--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Constructor
function Point(name, data)

  local self = {}
  self.name = name
  self.enable = data.enable or true

  -- Enable point
  self.Enable = function()

    EnableMarker(self.name, true)
    EnableArea(self.name, true)
    ShowBlip(self.name)

  end

  -- Disable point
  self.Disable = function()

    EnableMarker(self.name, false)
    EnableArea(self.name, false)
    HideBlip(self.name)

  end

  -- Remove
  self.Remove = function()

    RemoveMarker(self.name)
    RemoveArea(self.name)
    RemoveBlip(self.name)

  end

  -- Area
  if data.area ~= nil then
    local areaData = data.area
    areaData.enable = self.enable
    areaData.x = data.x
    areaData.y = data.y
    areaData.z = data.z
    self.area = AddArea(self.name, areaData)
  end

  -- Blip
  if data.blip ~= nil then
    local blipData = data.blip
    blipData.enable = self.enable
    blipData.x = data.x
    blipData.y = data.y
    blipData.z = data.z
    self.blip = AddBlip(self.name, blipData)
  end

  -- Marker
  if data.marker ~= nil then
    local markerData = data.marker
    markerData.enable = self.enable
    markerData.x = data.x
    markerData.y = data.y
    markerData.z = data.z
    self.marker = AddMarker(self.name, markerData)
  end

  return self

end
