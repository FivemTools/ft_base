--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_base
--

dependencies {
  "mysql-async",
}

client_scripts {
  "src/player/player.client.lua",
}

server_scripts {
  "@mysql-async/lib/MySQL.lua", -- MySQL
  "src/utils.server.lua",
  "settings.server.lua",

  --
  -- Player
  --
  "src/player/player.server.lua",
  "src/player/players.server.lua",


  --
  -- Debug
  --
  "src/debug/debug.server.lua",

}

exports {}

server_exports {
  "GetPlayerFromIdentifier",
  "GetPlayerFromId",
  "GetPlayers",
}
