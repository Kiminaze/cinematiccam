--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------
-- This script is client sided.


-- Just creating a table for config settings, dont touch.
Config = {} 


----------------------
-- General settings --
----------------------

-- What language should be used?
-- Look up what lange table are existing in 'Language.lua' and set the language string here.
-- The language string is the table name of the language list in 'Language.lua' like: 'Language.english' the string to use here is 'english'.
Config.language = "english"

-- Specify, if menu should be accessible via button press.
Config.useButton = true

-- Specify, if menu should be accessible via chat command.
Config.useCommand = true

-- Specify chat command prefix string.
-- That is what you use in the ingame chat like '/cam' to open the cinematic cam menu.
Config.command = "cam"

-- Specify, if this camera should be permission based.
-- For permission settings look in the 'Permission.lua' file.
Config.usePermissions = false

-- Show an extra option to have a completely free to move camera.
Config.detachOption = true

-- Values are in meters. Default: 5.0
-- Only works with Config.noMetaGaming = true or if you attche the camera to an object.
-- Dont set it above 350.0
Config.maxDistance = 5.0

-- This config will remove the camera attach function (on vehicle or other objects) if set to true.
-- If you set this to true, change also the Config.maxDistance to a short range like 5.0.
Config.noMetaGaming = false

-- Min and max speed settings for movement in m/s including increments. (Should always be above 0.0)
Config.minSpeed    = 0.1
Config.maxSpeed    = 10.0

-- Min and max precision settings for rotation including increments. (Should always be above 0.0)
Config.minPrecision    = 0.1
Config.incrPrecision   = 0.1
Config.maxPrecision    = 2.0

-- Min and max FoV (field of view) settings. (Should always be in between 1.0f and 130.0f!)
Config.minFov = 1.0
Config.maxFov = 130.0

-- settings for OrbitCam mode
Config.OrbitOffset      = vector3(0.0, 0.0, 0.5)
Config.OrbitControl     = false


Config.controls = {
    keyboard = {
        openMenu    = 178,  -- Delete
        hold        = 21,   -- Shift
        speedUp     = 15,   -- Mouse wheel up   -- with hold
        speedDown   = 14,   -- Mouse wheel down -- with hold

        zoomOut     = 14,   -- Mouse wheel down
        zoomIn      = 15,   -- Mouse wheel up

        forwards    = 32,   -- W
        backwards   = 33,   -- S
        left        = 34,   -- A
        right       = 35,   -- D
        up          = 22,   -- Space
        down        = 36,   -- Ctrl

        rollLeft    = 44,   -- Q
        rollRight   = 38,   -- E
    },
    controller = {
        openMenu    = 244,  -- Select -- hold for ~1 second

        holdSpeed   = 80,   -- O / B
        holdFov     = 21,   -- X / A
        up          = 172,  -- D-pad up
        down        = 173,  -- D-pad down

        rollLeft    = 37,   -- L1 / LB
        rollRight   = 44,   -- R1 / RB
    }
}

-- disables character/vehicle controls when using camera movements
Config.disabledControls = {
    30,     -- A and D (Character Movement)
    31,     -- W and S (Character Movement)
    21,     -- LEFT SHIFT
    36,     -- LEFT CTRL
    22,     -- SPACE
    44,     -- Q
    38,     -- E
    71,     -- W (Vehicle Movement)
    72,     -- S (Vehicle Movement)
    59,     -- A and D (Vehicle Movement)
    60,     -- LEFT SHIFT and LEFT CTRL (Vehicle Movement)
    85,     -- Q (Radio Wheel)
    86,     -- E (Vehicle Horn)
    15,     -- Mouse wheel up
    14,     -- Mouse wheel down
    37,     -- Controller R1 (PS) / RT (XBOX)
    80,     -- Controller O (PS) / B (XBOX)
    228,    -- 
    229,    -- 
    172,    -- 
    173,    -- 
    37,     -- 
    44,     -- 
    178,    -- 
    244,    -- 
}
