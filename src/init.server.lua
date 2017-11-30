--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Event is emited after resource is loded
AddEventHandler('onServerResourceStart', function(resource)
  if resource == "ft_base" then

    -- Send event
    TriggerEvent('ft_base:onResourceReady')

  end
end)
