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

local itemCamPrecision
local itemCamFov

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
    
    -- add additional control help
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 38, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 44, true), Cfg.strings.ctrlHelpRoll})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 36, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 21, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 30, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 31, true), Cfg.strings.ctrlHelpMove})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 2, true), ""})
    camMenu:AddInstructionButton({GetControlInstructionalButton(1, 1, true), Cfg.strings.ctrlHelpRotate})

    local itemToggleCam = NativeUI.CreateCheckboxItem(Cfg.strings.toggleCam, DoesCamExist(cam), Cfg.strings.toggleCamDesc)
    camMenu:AddItem(itemToggleCam)

    local precision = {}
    for i=0.1, 2.01, 0.1 do table.insert(precision, tostring(i)) end
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
    itemCamFov = NativeUI.CreateListItem(Cfg.strings.camFov, fovs, math.floor(currFov-Cfg.minFov)+1.0, Cfg.strings.camFovDesc)
    camMenu:AddItem(itemCamFov)
    
    local submenuFilter = _menuPool:AddSubMenu(camMenu, Cfg.strings.filter, Cfg.strings.filterDesc)
    camMenu.Items[#camMenu.Items]:SetLeftBadge(15)
    local itemFilter = NativeUI.CreateListItem(Cfg.strings.filter, Cfg.filterList, currFilter, Cfg.strings.filterDesc)
    submenuFilter:AddItem(itemFilter)
    local filterInten = {}
    for i=0.1, 2.01, 0.1 do table.insert(filterInten, tostring(i)) end
    local itemFilterIntensity = NativeUI.CreateListItem(Cfg.strings.filterInten, filterInten, currFilterIntensity, Cfg.strings.filterIntenDesc)
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
            _menuPool:RefreshIndex()
        else
            EndFreeCam()
            _menuPool:RefreshIndex()
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
        SetTimecycleModifier(Cfg.filterList[currFilter])
        SetTimecycleModifierStrength(tonumber(filterInten[newindex]))
        currFilterIntensity = newindex
    end

    submenuFilter.OnItemSelect = function(menu, item, index)
        if (item == itemDelFilter) then
            ClearTimecycleModifier()
            itemFilter._Index   = 1
            currFilter          = 1
            itemFilterIntensity._Index  = 10
            currFilterIntensity         = 10
        end
    end


    camMenu:GoDown()
    submenuFilter:GoDown()

    _menuPool:ControlDisablingEnabled(false)
    _menuPool:MouseControlsEnabled(false)

    --_menuPool:RefreshIndex()
end



--------------------------------------------------
------------------- FUNCTIONS --------------------
--------------------------------------------------

-- initialize camera
function StartFreeCam(fov)
    ClearFocus()

    local playerPed = GetPlayerPed(-1)
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, fov * 1.0)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, false)
    
    SetCamAffectsAiming(cam, false)

    if (isAttached) then
        AttachCamToEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    end
end

-- destroy camera
function EndFreeCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    
    offsetRotX = 0.0
    offsetRotY = 0.0
    offsetRotZ = 0.0

    cam = nil
end

-- process camera controls
function ProcessCamControls()
    -- disable 1st person as the 1st person camera can cause some glitches
    DisableFirstPersonCamThisFrame()
    
    local playerPed = GetPlayerPed(-1)
    local playerRot = GetEntityRotation(playerPed, 2)

    local rotX = playerRot.x
    local rotY = playerRot.y
    local rotZ = playerRot.z

    if (_menuPool:IsAnyMenuOpen()) then
        -- disable character/vehicle controls
        for k, v in pairs(Cfg.disabledControls) do
            DisableControlAction(0, v, true)
        end
        
        -- mouse controls
        offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * 8.0)
        offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * 8.0)
        if (offsetRotX > 90.0) then offsetRotX = 90.0 elseif (offsetRotX < -90.0) then offsetRotX = -90.0 end
        if (offsetRotY > 90.0) then offsetRotY = 90.0 elseif (offsetRotY < -90.0) then offsetRotY = -90.0 end
        if (offsetRotZ > 360.0) then offsetRotZ = offsetRotZ - 360.0 elseif (offsetRotZ < -360.0) then offsetRotZ = offsetRotZ + 360.0 end
        
        -- calculate coord and rotation offset of cam
        if (isAttached) then
            local offsetCoords = GetOffsetFromEntityGivenWorldCoords(playerPed, GetCamCoord(cam))
            local x = offsetCoords.x
            local y = offsetCoords.y
            local z = offsetCoords.z
            
            if (IsDisabledControlPressed(1, 32)) then -- W
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                if (offsetRotY < -360.0) then offsetRotY = offsetRotY + 360.0 end
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
                if (offsetRotY > 360.0) then offsetRotY = offsetRotY - 360.0 end
            end

            -- set coords of cam
            AttachCamToEntity(cam, playerPed, x, y, z, true)
            
            SetFocusEntity(playerPed)

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
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 33)) then -- S
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = offsetRotZ / 90
                    multCoordY = 1.0 - (math.abs(offsetRotZ) / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = 1.0 - (offsetRotZ - 90.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 90.0) / 90)
                    end
                    multCoordY = - (math.abs(offsetRotZ) - 90.0) / 90
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - ((offsetRotZ - 180.0) / 90)
                    else
                        multCoordX = - (offsetRotZ + 180.0) / 90
                    end
                    multCoordY = - 1.0 + (math.abs(offsetRotZ) - 180.0) / 90
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 270.0) / 90))
                    else
                        multCoordX = 1.0 + (offsetRotZ + 270.0) / 90
                    end
                    multCoordY = (math.abs(offsetRotZ) - 270.0) / 90
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 34)) then -- A
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 35)) then -- D
                local multCoordY = 0.0
                local multCoordX = 0.0
                if ((offsetRotZ >= 0.0 and offsetRotZ <= 90.0) or (offsetRotZ <= 0.0 and offsetRotZ >= -90.0)) then
                    multCoordX = 1.0 - (math.abs(offsetRotZ) / 90)
                    multCoordY = - (offsetRotZ / 90)
                elseif ((offsetRotZ >= 90.0 and offsetRotZ <= 180.0) or (offsetRotZ <= -90.0 and offsetRotZ >= -180.0)) then
                    if (offsetRotZ >= 90.0) then
                        multCoordX = - (offsetRotZ - 90.0) / 90
                        multCoordY = - (1.0 - (math.abs(offsetRotZ) - 90.0) / 90)
                    else
                        multCoordX = (offsetRotZ + 90.0) / 90
                        multCoordY = 1.0 - ((math.abs(offsetRotZ) - 90.0) / 90)
                    end
                elseif ((offsetRotZ >= 180.0 and offsetRotZ <= 270.0) or (offsetRotZ <= -180.0 and offsetRotZ >= -270.0)) then
                    if (offsetRotZ >= 180.0) then
                        multCoordX = - (1.0 - ((offsetRotZ - 180.0) / 90))
                        multCoordY = (math.abs(offsetRotZ) - 180.0) / 90
                    else
                        multCoordX = - (1.0 + (offsetRotZ + 180.0) / 90)
                        multCoordY = - (math.abs(offsetRotZ) - 180.0) / 90
                    end
                elseif ((offsetRotZ >= 270.0 and offsetRotZ <= 360.0) or (offsetRotZ <= -270.0 and offsetRotZ >= -360.0)) then
                    if (offsetRotZ >= 270.0) then
                        multCoordX = (offsetRotZ - 270.0) / 90
                        multCoordY = 1.0 - (math.abs(offsetRotZ) - 270.0) / 90
                    else
                        multCoordX = - (offsetRotZ + 270.0) / 90
                        multCoordY = - (1.0 - ((math.abs(offsetRotZ) - 270.0) / 90))
                    end
                end

                x = x + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordX)
                y = y - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index] * multCoordY)
            end
            if (IsDisabledControlPressed(1, 21)) then -- SHIFT
                z = z + (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 36)) then -- LEFT CTRL
                z = z - (0.1 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 44)) then -- Q
                offsetRotY = offsetRotY - (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
            end
            if (IsDisabledControlPressed(1, 38)) then -- E
                offsetRotY = offsetRotY + (1.0 * itemCamPrecision.Items[itemCamPrecision._Index])
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
