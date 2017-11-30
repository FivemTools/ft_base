--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

dependencies {

  "mysql-async",
  "spawnmanager",

}

client_scripts {

  "settings.client.lua",
  "src/utils.client.lua",

  -- Frame
  "src/frame.client.lua",

  -- Player
  "src/player/manager/player.client.lua",

  -- Money
  "src/player/money/money.client.lua",

  -- Area
  "src/area/area.client.lua",
  "src/area/areas.client.lua",

  -- Marker
  "src/marker/marker.client.lua",
  "src/marker/markers.client.lua",

  -- Blip
  "src/blip/blip.client.lua",
  "src/blip/blips.client.lua",

  -- Point
  "src/point/point.client.lua",
  "src/point/points.client.lua",

  -- Ui
  "src/ui/ui.client.lua",

  -- Menu
  "src/menu/menu.client.lua",
  "src/menu/menus.client.lua",

  -- Player Spawn
  "src/player/spawn/spawn.client.lua",

  -- Spawn Ped
  "src/npc/spawn.client.lua",

  -- Dispatch NPC
  "src/npc/dispatch.client.lua",

  -- Wanted Level
  "src/player/wanted/wanted.client.lua",

  -- Lock
  --"src/vehicle/lock/lock.client.lua",

}

exports {

  -- Player
  "GetPlayer",
  "AddPlayerMethod",
  "PlayerCall",

  -- Money
  "CreateMoney",

  -- Dispatch
  "DisableDispatch",
  "EnableDispatch",
  "EnableDispatchCopsForPlayer",

  -- Ped
  "ChangeTrafficDensity",
  "ChangePedDensity",
  "ChangeParkedVehicleDensity",
  "EnableCopsSpawn",
  "EnableBoatsSpawn",
  "EnableTrainsSpawn",
  "EnableGarbageTrucksSpawn",
  "AddTerminateScripts",
  "RemoveTerminateScripts",

  -- Area
  "AddArea",
  "RemoveArea",
  "EnableArea",
	"CurrentArea",

  -- Marker
  "AddMarker",
  "RemoveMarker",
  "EnableMarker",
  "CurrentMarker",

  -- Blip
  "AddBlip",
  "RemoveBlip",
  "ShowBlip",
  "HideBlip",

  -- Point
  "AddPoint",
  "RemovePoint",
  "EnablePoint",
  "DisablePoint",

  -- Ui
  "HelpPromt",
  "LoadingPromt",
  "ShowPromt",
  "Message",
  "Notification",
  "Text",
  "OpenTextInput",

  -- Menu
  "AddMenu",
  "RemoveMenu",
  "MenuIsOpen",
  "CurrentMenu",
  "FreezeMenu",
  "OpenMenu",
  "CloseMenu",
  "NextMenu",
  "BackMenu",
  "CleanMenuButtons",
  "SetMenuButtons",
  "AddMenuButton",
  "RemoveMenuButton",
  "SetMenuValue",

  -- Utils
  "CommaValue",
  "Round",
  "TableLength",
  "GetEntityDirection",

  -- Wanted Level
  "DisableWantedLevel",

}

server_scripts {

  "@mysql-async/lib/MySQL.lua", -- MySQL
  "src/utils.server.lua",
  "settings.server.lua",

  -- SQL
  "src/sql/orm.delete.server.lua",
  "src/sql/orm.insert.server.lua",
  "src/sql/orm.select.server.lua",
  "src/sql/orm.update.server.lua",

  -- Player
  "src/player/manager/player.server.lua",
  "src/player/manager/players.server.lua",

  -- Access
  --"src/player/access/access.client.lua",

  -- Player Spawn
  "src/player/spawn/spawn.server.lua",

  -- Money
  "src/player/money/money.server.lua",

  -- Debug
  "src/debug/debug.server.lua",

  -- Init
  "src/init.server.lua",

  -- Lock
  --"src/vehicle/lock/lock.server.lua",

}

server_exports {
  -- Money
  "CreateMoney",

  -- Player
  "GetPlayerFromIdentifier",
  "GetPlayerFromServerId",
  "GetPlayerFromId",
  "GetIdentifier",
  "GetPlayers",
  "PlayerCall",
  "AddPlayerCreateCallback",

  -- Utils
  "Round",

}
