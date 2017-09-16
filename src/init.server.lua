--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

-- Event is emited after resource is loded
AddEventHandler('onServerResourceStart', function(resource)
  if resource == "ft_base" then

    -- Send event
    TriggerEvent('ft_base:onResourceReady')

  end
end)
