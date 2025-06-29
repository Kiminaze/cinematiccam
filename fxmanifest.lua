--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

fx_version "cerulean"
games { "gta5" }

author "Philipp Decker"
description "Cinematic camera for fancy screenshots or videos!"
version "1.1.0"

server_scripts {
	"server/permission.lua"
}

client_scripts {
	"@NativeUI/NativeUI.lua", -- Please check that your NativeUI script file is named like this!
	"client/language.lua",
	"client/boneSelects.lua",
	"localization/*.lua", -- This will load all localization files, no need to add them.
	"config.lua",
	"client/cameraFilter.lua",
	"client/client.lua"
}

dependency "NativeUI"
