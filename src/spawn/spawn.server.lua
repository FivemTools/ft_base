--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

AddPlayerDropCallback(function(player)

  player:Save({
    "posX",
    "posY",
    "posZ",
    "heading",
  })

end)
