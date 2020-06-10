--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

**What exactly is the "Cinematic Cam"?**
The Cinematic Cam provides the user with an easy to use "additional" camera, that can be moved freely in the world. Additionally it can be attached to any npc/player/vehicle in the game in order to provide something similar to a "Dashcam" or just for fancy screenshots or videos.
You can set it on a specific position and angle relative to your character and the camera will move with the entity.

**Features included:**
- complete control using NativeUILua by Frazzle ( [NativeUILua](https://github.com/FrazzIe/NativeUILua) )
OR
- complete control using NativeUILua-Reloaded by iTexZoz ( [NativeUILua-Reloaded](https://github.com/iTexZoz/NativeUILua_Reloaded) )
- toggle the camera on / off
- moving and rotating on all axes
- using mouse AND controller input for rotation
- setting precise rotation
- setting field of view and speed of the camera
- applying / removing a filter
- setting filter intensity
- toggle minimap on / off
- attach camera to any npc/player/vehicle entity
- toggle between player and camera control
- you can now set up a permission based system rather easily

**Switching between NativeUILua and NativeUILua-Reloaded:**
- Change the client_scripts in fxmanifest.lua to whichever one you are using (make sure the names are correct as well!)
- Change Cfg.useNativeUI and Cfg.useNativeUIReloaded in config.lua to reflect the above changes

**Setting up a permission based system:**
- Uncomment server_scripts in the fxmanifest.lua
- Change Cfg.usePermissions to true in config.lua
- Open server.lua and insert whatever code you need in between the two comments and set the variable "isWhitelisted" to your result
