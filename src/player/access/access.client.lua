--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Join server
AddEventHandler("playerConnecting", function(playerName, reason)

  -- local source = source
  -- local steamID = GetIdentifier(source)
  -- local banned = false

  print("WHITELIST: " .. playerName .. " essaye de se connecter")

  -- Check player conenct
  -- local player  = SelectSQL("ft_players", "*", { identifier = identifier })
  -- TablePrint(player)

  reason("You're banned from this server")
  --deferrals.done("Test")
  CancelEvent()
  print("WHITELIST: " .. playerName .. " n'a pas STEAM d'ouvert. KICK")

end)
