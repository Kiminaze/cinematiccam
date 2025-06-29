
--------------------
-- Language lists --
--------------------
-- This table contains a list with all text output strings and labels for menus.
-- Each language has its own file. You can copy and past this file, change the name and replace the strings with a new language.


-- NERVER REMOVE THIS TABLE! This is the default language if something goes wrong. Dont touch it, just copy and paste it if you want to use another language!
Language["english"] = {
    noAccessError   = "[ERROR] CinematicCam: At least one of the following values must be true! Config.useButton, Config.useCommand",
    wrongUIError    = "[ERROR] CinematicCam: Only specify exactly ONE UI in the config file!",

    menuTitle       = "Cinematic Cam",
    menuSubtitle    = "Control the Cinematic Camera",
    
    toggleCam       = "Camera active",
    toggleCamDesc   = "Toggle camera on/off",

    precision       = "Camera Precision",
    precisionDesc   = "Change camera precision movement",

    filter          = "Filter",
    filterDesc      = "Change camera Filter",

    filterInten     = "Filter Intensity",
    filterIntenDesc = "Change camera Filter Intensity",
    
    delFilter       = "Reset Filter",
    delFilterDesc   = "Remove filter and reset values",

    showMap         = "Show Minimap",
    showMapDesc     = "Toggle minimap on/off",

    freeFly         = "Toggle Free Fly Mode",
    freeFlyDesc     = "Switch to Free Fly or back to Drone Mode",

    charControl     = "Toggle Character Control",
    charControlDesc = "Switch to Character or back to Camera Control",

    attachCam       = "Attach camera to: ",
    attachCamDesc   = "Attach the camera to an entity in front of it",

    pointEntity     = "Point camera at entity",
    pointEntityDesc = "Toggle pointing at selected entity",

    ctrlHelpRoll    = "Roll Left/Right",
    ctrlHelpMove    = "Movement",
    ctrlHelpRotate  = "Rotate",

    OrbitLabel       = "OrbitCam",
    OrbitDescription = "An orbiting camera above your character.",
    OrbitSpeedLabel  = "Rotation speed",
    OrbitSpeedDesc   = "How fast the camera rotates.",
    OrbitPlayerCon      = "Controls",
    OrbitPlayerConDesc  = "Activate or deactivate player controls.",
    OrbitBoneLabel      = "Bone",
    OrbitBoneDesc       = "The bone that the camera orbits around."
}