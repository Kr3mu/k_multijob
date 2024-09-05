fx_version "cerulean"
game "gta5"
author "kr3mu"
description "MultiJob for fivem"
version "1.0"


client_scripts {
  "client/*.lua",
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/Classes/*.lua",
  "server/*.lua",

}

shared_scripts {
  "@es_extended/imports.lua",
  "shared/*.lua"
}
