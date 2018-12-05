--------------------------------------------------
------- FREECAM FOR FIVEM MADE BY KIMINAZE -------
--------------------------------------------------



--------------------------------------------------
------------------- VARIABLES --------------------
--------------------------------------------------

-- main variables
local cam = nil

local offsetRotX = 0.0
local offsetRotY = 0.0
local offsetRotZ = 0.0

local itemCamPrecision = 1.0

local currFilter = 1
local currFilterIntensity = 10

local isAttached = true
local camCoords

-- menu variables
local _menuPool = NativeUI.CreatePool()
local camMenu

-- print error if no menu access was specified
if (not(Cfg.useButton or Cfg.useCommand)) then
    print(Cfg.strings.noAccessError)
end



--------------------------------------------------
---------------------- LOOP ----------------------
--------------------------------------------------
Citizen.CreateThread(function()
    camMenu = NativeUI.CreateMenu(Cfg.strings.menuTitle, Cfg.strings.menuSubtitle)
	_menuPool:Add(camMenu)

    while true do
        Citizen.Wait(1)
        
        -- process menu
        if (_menuPool:IsAnyMenuOpen()) then
            _menuPool:ProcessMenus()
        end

        -- open / close menu on button press
        if (Cfg.useButton and IsControlJustReleased(1, Cfg.button)) then
            if (camMenu:Visible()) then
                camMenu:Visible(false)
            else
                GenerateCamMenu()
                camMenu:Visible(true)
            end
        end

        -- process cam controls if cam exists
        if (cam) then
            ProcessCamControls()
        end
    end
end)



--------------------------------------------------
---------------------- MENU ----------------------
--------------------------------------------------
function GenerateCamMenu()
    _menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()
    
    camMenu = NativeUI.CreateMenu(Cfg.strings.menuTitle, Cfg.strings.menuSubtitle)
    _menuPool:Add(camMenu)


    local itemToggleCam = NativeUI.CreateCheckboxItem(Cfg.strings.toggleCam, DoesCamExist(cam), Cfg.strings.toggleCamDesc)
    camMenu:AddItem(itemToggleCam)

    local itemMoveCam = NativeUI.CreateItem(Cfg.strings.moveCam, Cfg.strings.moveCamDesc)
    camMenu:AddItem(itemMoveCam)
    if (not DoesCamExist(cam)) then
        camMenu.Items[#camMenu.Items]:SetLeftBadge(21)
    end

    local itemRotCam = NativeUI.CreateItem(Cfg.strings.rotCam, Cfg.strings.rotCamDesc)
    camMenu:AddItem(itemRotCam)
    if (not DoesCamExist(cam)) then
        camMenu.Items[#camMenu.Items]:SetLeftBadge(21)
    end

    local precision = {}
    for i=0.1, 2.0, 0.1 do table.insert(precision, i) end
    itemCamPrecision = NativeUI.CreateListItem(Cfg.strings.precision, precision, 10, Cfg.strings.precisionDesc)
    camMenu:AddItem(itemCamPrecision)

    local fovs = {}
    for i=Cfg.minFov, Cfg.maxFov, 1.0 do table.insert(fovs, i) end
    local currFov
    if (cam) then
        currFov = GetCamFov(cam)
    else
        currFov = GetGameplayCamFov()
    end
    local itemCamFov = NativeUI.CreateListItem(Cfg.strings.camFov, fovs, currFov-Cfg.minFov+1.0, Cfg.strings.camFovDesc)
    camMenu:AddItem(itemCamFov)
    
    local submenuFilter = _menuPool:AddSubMenu(camMenu, Cfg.strings.filter, Cfg.strings.filterDesc)
    camMenu.Items[#camMenu.Items]:SetLeftBadge(15)
    local itemFilter = NativeUI.CreateListItem(Cfg.strings.filter, Cfg.filterList, currFilter, Cfg.strings.filterDesc)
    submenuFilter:AddItem(itemFilter)
    local itemFilterIntensity = NativeUI.CreateListItem(Cfg.strings.filterInten, Cfg.filterInten, currFilterIntensity, Cfg.strings.filterIntenDesc)
    submenuFilter:AddItem(itemFilterIntensity)
    local itemDelFilter = NativeUI.CreateItem(Cfg.strings.delFilter, Cfg.strings.delFilterDesc)
    submenuFilter:AddItem(itemDelFilter)
    
    local itemShowMap = NativeUI.CreateCheckboxItem(Cfg.strings.showMap, not IsRadarHidden(), Cfg.strings.showMapDesc)
    camMenu:AddItem(itemShowMap)

    local itemAttachCam = NativeUI.CreateCheckboxItem(Cfg.strings.attachCam, isAttached, "")
    if (Cfg.detachOption) then
        camMenu:AddItem(itemAttachCam)
    end
    

    itemToggleCam.CheckboxEvent = function(menu, item, checked)
        if (checked) then
            StartFreeCam(itemCamFov.Items[itemCamFov._Index])
            itemMoveCam:SetLeftBadge(0)
            itemRotCam:SetLeftBadge(0)
        else
            EndFreeCam()
            itemMoveCam:SetLeftBadge(21)
            itemRotCam:SetLeftBadge(21)
        end
    end

    itemCamFov.OnListChanged = function(menu, item, newindex)
        if (DoesCamExist(cam)) then
            SetCamFov(cam, itemCamFov.Items[newindex])
        end
    end

    itemShowMap.CheckboxEvent = function(menu, item, checked)
        DisplayRadar(checked)
    end

    if (Cfg.detachOption) then
        itemAttachCam.CheckboxEvent = function(menu, item, checked)
            if (checked) then
                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)
                local rot       = GetEntityRotation(playerPed)
                SetCamCoord(cam, coords)
                SetCamRot(cam, rot)
                Citizen.Wait(1)
                AttachCamToEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
            else
                DetachCam(cam)
            end

            isAttached = checked
        end
    end


    itemFilter.OnListChanged = function(menu, item, newindex)
        SetTimecycleModifier(Cfg.filterList[newindex])
        currFilter = newindex
    end

    itemFilterIntensity.OnListChanged = function(menu, item, newindex)
        SetTimecycleModifierStrength(itemFilterIntensity.Items[newindex])
        currFilterIntensity = newindex
    end

    submenuFilter.OnItemSelect = function(menu, item, index)
        if (item == itemDelFilter) then
            ClearTimecycleModifier()
            itemFilter._Index = 1
            itemFilterIntensity._Index = 10
        end
    end


    camMenu:GoDown()
    submenuFilter:GoDown()

    _menuPool:ControlDisablingEnabled(false)
    _menuPool:MouseControlsEnabled(false)
end



--------------------------------------------------
------------------- FUNCTIONS --------------------
--------------------------------------------------

-- initialize camera
function StartFreeCam(fov)
    local playerPed = GetPlayerPed(-1)
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, fov * 1.0)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, false)

    if (isAttached) then
        AttachCamToEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    end
end

-- destroy camera
function EndFreeCam()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    
    offsetRotX = 0.0
    offsetRotY = 0.0
    offsetRotZ = 0.0

    cam = nil
end

-- process camera controls
function ProcessCamControls()
    local playerPed = GetPlayerPed(-1)
    local playerRot = GetEntityRotation(playerPed, 2)

    local rotX = playerRot.x
    local rotY = playerRot.y
    local rotZ = playerRot.z

    if (camMenu:Visible()) then
        -- disable character/vehicle controls
        for k, v in pairs(Cfg.disabledControls) do
            DisableControlAction(0, v, true)
        end

        -- calculate coord and rotation offset of cam
        if (isAttached) then
            local offsetCoords = GetOffsetFromEntityGivenWorldCoords(playerPed, GetCamCoord(cam))
            local x = offsetCoords.x
            local y = offsetCoords.y
            local z = offsetCoords.z
            
            if (IsDisabledControlPressed(1, 32)) then -- W
                if (camMenu:CurrentSelection() == 2) then
                    y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotX = offsetRotX - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                if (camMenu:CurrentSelection() == 2) then
                    y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotX = offsetRotX + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                if (camMenu:CurrentSelection() == 2) then
                    x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotZ = offsetRotZ + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                if (camMenu:CurrentSelection() == 2) then
                    x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotZ = offsetRotZ - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                if (camMenu:CurrentSelection() == 2) then
                    z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                if (camMenu:CurrentSelection() == 2) then
                    z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                if (camMenu:CurrentSelection() == 3) then
                    offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                if (camMenu:CurrentSelection() == 3) then
                    offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
    
            -- set coords of cam
            AttachCamToEntity(cam, playerPed, x, y, z, true)

            -- reset coords of cam if too far from player
            if (Vdist(0.0, 0.0, 0.0, x, y, z) > Cfg.maxDistance) then
                AttachCamToEntity(cam, playerPed, offsetCoords.x, offsetCoords.y, offsetCoords.z, true)
            end
        else
            local camCoords = GetCamCoord(cam)
            local x = camCoords.x
            local y = camCoords.y
            local z = camCoords.z
            
            if (IsDisabledControlPressed(1, 32)) then -- W
                if (camMenu:CurrentSelection() == 2) then
                    y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotX = offsetRotX - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                if (camMenu:CurrentSelection() == 2) then
                    y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotX = offsetRotX + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                if (camMenu:CurrentSelection() == 2) then
                    x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotZ = offsetRotZ + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                if (camMenu:CurrentSelection() == 2) then
                    x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                elseif (camMenu:CurrentSelection() == 3) then
                    offsetRotZ = offsetRotZ - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                if (camMenu:CurrentSelection() == 2) then
                    z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                if (camMenu:CurrentSelection() == 2) then
                    z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                if (camMenu:CurrentSelection() == 3) then
                    offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                if (camMenu:CurrentSelection() == 3) then
                    offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                end
            end
            
            SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
            SetCamCoord(cam, x, y, z)
        end
    end
    
    -- set rotation of cam
    if (isAttached) then
        SetCamRot(cam, rotX+offsetRotX, rotY+offsetRotY, rotZ+offsetRotZ, 2)
    else
        SetCamRot(cam, offsetRotX, offsetRotY, offsetRotZ, 2)
    end
end



--------------------------------------------------
-------------------- COMMANDS --------------------
--------------------------------------------------

-- register command if specified in config
if (Cfg.useCommand) then
    RegisterCommand(Cfg.command, function(source, args, raw)
        if (camMenu:Visible()) then
            camMenu:Visible(false)
        else
            GenerateCamMenu()
            camMenu:Visible(true)
        end
    end)
end
