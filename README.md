
# Cinematic Cam

The Cinematic Cam provides the user with an easy to use "additional" camera, that can be moved 
freely in the world. Additionally it can be attached to any npc/player/vehicle in the game in order 
to provide something similar to a "Dashcam" or just for fancy screenshots or videos. You can set it 
on a specific position and angle relative to your character and the camera will move with the 
entity.


## Requirements

- NativeUILua by Frazzle ([NativeUILua](https://github.com/FrazzIe/NativeUILua/archive/refs/heads/master.zip))


## 📋 Features

- Toggle the camera on/off.
- Moving and rotating on all axes.
- Using mouse _and_ controller input for rotation.
- Setting precise rotation.
- Setting field of view and speed of the camera.
- Applying/removing a filter.
- Setting filter intensity.
- Toggle minimap on/off.
- Attach camera to any npc/player/vehicle entity.
- Toggle between player and camera control.
- You can set up a permission based system rather easily.


## Setting up a permission based system

- Set `Config.usePermissions` to true in `config.lua`
- Add ace permissions with the name `"CinematicCamPermission"` in your `server.cfg`
- Example: `add_ace identifier.steam:steamidhere "CinematicCamPermission" allow` (check permission.lua for more)


## Known issue

If you get the following error:
```
SCRIPT ERROR: @cinematiccam/client/client.lua:180: attempt to call a nil value (method 'Remove')
```
Please make sure you downloaded the correct [NativeUILua](https://github.com/FrazzIe/NativeUILua/archive/refs/heads/master.zip)
from this link.
The "latest release" is an older version and hasn't been updated by the developer with the latest 
functions.


## 💾 Download

https://github.com/Kiminaze/cinematiccam/releases/latest/download/cinematiccam.zip


## ❓ Support

https://discord.kiminaze.de
