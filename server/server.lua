--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------
-- This script is server sided.


-- This function is loading your language file from 'config.lua'.
SelectLanguage(Config.language);


--------------
-- Check UI --
--------------

-- Checks whether the required NativeUI version is started.
-- Prints a server-side warning if it is not.
local _menuPool = NativeUI.CreatePool()

if (_menuPool.Remove == nil) then
	print(Config.strings.noUIStarted)
	return
end



------------
-- Events --
------------

-- This event is triggerd from client side to check the permissions of a user.
RegisterServerEvent("CinematicCam:requestPermissions")
AddEventHandler("CinematicCam:requestPermissions", function()
	local isWhitelisted = false;
	
	-- To add a specific user with an steam identifier, add this line to your 'server.cfg':
	-- add_ace identifier.steam:steamidhere "CinematicCamPermission" allow
	
	-- or add permissions with the rockstar license:
	-- add_ace identifier.license:rockstarlicenshere "CinematicCamPermission" allow
	
	-- or add a group ace permission in your 'server.cfg':
	-- add_ace group.owner "CinematicCamPermission" allow
	-- add_ace group.admin "CinematicCamPermission" allow
	
	if IsPlayerAceAllowed(source, "CinematicCamPermission") then
		isWhitelisted = true;
	end

	TriggerClientEvent("CinematicCam:receivePermissions", source, isWhitelisted)
end)
