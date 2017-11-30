--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

AddPlayerDropCallback(function(player)

  player:Save({
    "pos_x",
    "pos_y",
    "pos_z",
    "heading",
  })

end)
