
-------------------
-- Language lists --
--------------------
-- This table contains a list with all text output strings and labels for menus.
-- Each language has its own file. You can copy and past this file, change the name and replace the strings with a new language.


Language["german"] = {
    noAccessError   = "[Fehler] CinematicCam: Mindestens einer der folgenden Variablen muss zutreffen: Config.useButton oder Config.useCommand und keine der beiden trifft gerade zu!",
    wrongUIError    = "[Fehler] CinematicCam: In der config.lua darf maximal eine UI angegeben werden, es sind gerade mehrere aktiv!",
    
    menuTitle       = "CinematicCam",
    menuSubtitle    = "Die CinematicCam Kontrollen",

    toggleCam       = "Kamera de-/aktivieren",
    toggleCamDesc   = "Schalte die Kamera ein und aus",

    precision       = "Kamera Geschwindigkeit",
    precisionDesc   = "Ändere die Geschwindigkeit der Kamerabewegung",

    filter          = "Filter",
    filterDesc      = "Wechsel den Kamerafilter",

    filterInten     = "Filter Intensität",
    filterIntenDesc = "Wechsel die Intensität des Kamerafilters",
    
    delFilter       = "Filter zurücksetzen",
    delFilterDesc   = "Setze den Filter zurück und stelle alles auf Standard ein",

    showMap         = "Zeige die Minimap",
    showMapDesc     = "Schalte die Minimap an oder aus",

    freeFly         = "Wechsle zu Freie-Kamera",
    freeFlyDesc     = "Wechsel in den Freie-Kamera Modus",

    charControl     = "Wechsel Charakterkontrolle",
    charControlDesc = "Wechsel zwischen Kamera- und Charakterkontrolle",

    attachCam       = "Befestige die Kamera an: ",
    attachCamDesc   = "Befestige die Kamera vor einem Objekt",

    pointEntity     = "Zentriere Kamera auf ein Objekt",
    pointEntityDesc = "Wechsel Zentrierung auf das ausgewählte Objekt",

    ctrlHelpRoll    = "Rollen Links/Rechts",
    ctrlHelpMove    = "Bewegen",
    ctrlHelpRotate  = "Drehen",

    OrbitLabel       = "OrbitCam",
    OrbitDescription = "Eine Kamera die sich um den Charakter dreht.",
    OrbitSpeedLabel  = "Umdrehungsstärke",
    OrbitSpeedDesc   = "Wie schnell sich die Kamera dreht.",
    OrbitPlayerCon      = "Kontrolle",
    OrbitPlayerConDesc  = "Aktiviere oder deaktiviere Spielereingaben.",
    OrbitBoneLabel      = "Bone",
    OrbitBoneDesc       = "Der bone um den die Kamera sich dreht."
}