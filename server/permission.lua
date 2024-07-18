--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------
-- This script is server sided.


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
	if IsPlayerAceAllowed(source, "CinematicCamPermission") then
		isWhitelisted = true;
	end

	TriggerClientEvent("CinematicCam:receivePermissions", source, isWhitelisted)
end)
