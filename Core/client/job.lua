-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
local inDuty = false
local inStash = false
local inTrash = false
local inAmoury = false
local inHelicopter = false
local inImpound = false
local inGarage = false

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function GetDeptConfig()
    local plrJob = string.upper(exports['qb-core']:GetCoreObject().Functions.GetPlayerData().job.name)

    return Config.Departments[plrJob]
end

local function GetNearestStation(Dept)
    local dept = Config.Departments[Dept]
    local c = GetEntityCoords(PlayerPedId())
    local nearest = nil

    for _,v in pairs(dept.Stations) do
        local sc = vector3(v.coords[1], v.coords[2], v.coords[3])
        local d = #(sc - c)
        if d < 200.0 then
            if nearest == nil then
                nearest = {v, d}
            else
                if d < nearest[2] then
                    nearest = {v, d}
                end
            end
        end
    end

    return nearest[1], nearest[2]
end

local function SetCarItemsInfo(vehicleModel)
	local items = {}
	for _, item in pairs(GetDeptConfig().VehicleSettings[vehicleModel].Settings.Items) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	GetDeptConfig().VehicleSettings[vehicleModel].Settings.Items = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function TakeOutImpound(vehicle)
    local coords = Config.Locations["impound"][currentGarage]
    if coords then
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, coords.w)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('police:server:TakeOutImpound', vehicle.plate, currentGarage)
                closeMenuFull()
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, vehicle.vehicle, coords, true)
    end
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Departments[currentGarage[1]].Stations[currentGarage[2]].VehicleGarage
    if coords then
        print("Creating Vehicle " .. vehicleInfo .. ", " .. coords)

        TriggerServerEvent("cpolice:server:CanTakeOutVehicle", vehicleInfo,  GetDeptConfig(), coords)
    end
end

RegisterNetEvent("cpolice:client:TakeOutVehicle", function(vehicleInfo, coords)
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetCarItemsInfo(vehicleInfo)

        SetVehicleNumberPlateText(veh, GetDeptConfig().PlainText .. tostring(math.random(1000, 9999)))

        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()

        if GetDeptConfig().VehicleSettings[vehicleInfo] ~= nil then
            if GetDeptConfig().VehicleSettings[vehicleInfo].Settings.extras ~= nil then
                QBCore.Shared.SetDefaultVehicleExtras(veh, GetDeptConfig().VehicleSettings[vehicleInfo].Settings.extras)
            end
            if GetDeptConfig().VehicleSettings[vehicleInfo].Settings.livery ~= nil then
                SetVehicleLivery(veh, GetDeptConfig().VehicleSettings[vehicleInfo].Settings.livery)
            end
        end

        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), GetDeptConfig().VehicleSettings[vehicleInfo].Settings.Items)
        SetVehicleEngineOn(veh, true, true)

    end, vehicleInfo, coords, true)
end)

RegisterNetEvent("cpolice:client:RejectTakeOutVehicle", function()
    QBCore.Functions.Notify("The Department does not have enough funds for that vehicle.", "error")
end)

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if IsLawEnforcement() then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for d,dept in pairs(Config.Departments) do
        for s,station in pairs(dept.Stations) do
            for k,_ in pairs(station.Armory.Items) do
                if k < 6 then
                    Config.Departments[d].Stations[s].Armory.Items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
                end
            end
        end
    end
end

local function CombineVehicleAuthorization()
    local VehList = {}

    local plrData = QBCore.Functions.GetPlayerData()
    local GradeAuth = plrData.job.grade.level
    local SubsAuth = plrData.metadata["leo_subs"]

    for i,v in pairs(GetDeptConfig().Vehicles[GradeAuth]) do
        VehList[i] = v
    end

    if SubsAuth ~= nil and GetDeptConfig().Subdivisions ~= nil then
        for _,sub in pairs(GetDeptConfig().Subdivisions) do
            if SubsAuth[sub] == true then
                for i,v in pairs(GetDeptConfig().Vehicles[sub]) do
                    VehList[i] = v
                end
            end
        end
    end

    return VehList
end

function MenuGarage(currentSelection)
    local vehicleMenu = {
        {
            header = Lang:t('menu.garage_title'),
            isMenuHeader = true
        }
    }

    --local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    --local authorizedVehicles = GetDeptConfig().Vehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    local authorizedVehicles = CombineVehicleAuthorization()
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicle",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    if IsArmoryWhitelist() then
        for veh, label in pairs(Config.WhitelistedVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                header = label,
                txt = "",
                params = {
                    event = "police:client:TakeOutVehicle",
                    args = {
                        vehicle = veh,
                        currentSelection = currentSelection
                    }
                }
            }
        end
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function MenuImpound(currentSelection)
    local impoundMenu = {
        {
            header = Lang:t('menu.impound'),
            isMenuHeader = true
        }
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_impound"), "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt =  Lang:t('info.vehicle_info', {value = enginePercent, value2 = currentFuel}),
                    params = {
                        event = "police:client:TakeOutImpound",
                        args = {
                            vehicle = v,
                            currentSelection = currentSelection
                        }
                    }
                }
            end
        end


        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = Lang:t('menu.close'),
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            exports['qb-menu']:openMenu(impoundMenu)
        end
    end)

end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function(_, cb)
    SetNuiFocus(false, false)
    inFingerprint = false
    cb('ok')
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(_, cb)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
    cb("ok")
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['LegacyFuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
           QBCore.Functions.Progressbar('impound', Lang:t('progressbar.impound'), 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'missheistdockssetup1clipboard@base',
                anim = 'base',
                flags = 1,
            }, {
                model = 'prop_notepad_01',
                bone = 18905,
                coords = { x = 0.1, y = 0.02, z = 0.05 },
                rotation = { x = 10.0, y = 0.0, z = 0.0 },
            },{
                model = 'prop_pencil_01',
                bone = 58866,
                coords = { x = 0.11, y = -0.02, z = 0.001 },
                rotation = { x = -120.0, y = 0.0, z = 0.0 },
            }, function() -- Play When Done
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)
                QBCore.Functions.DeleteVehicle(vehicle)
                TriggerEvent('QBCore:Notify', Lang:t('success.impounded'), 'success')
                ClearPedTasks(ped)
            end, function() -- Play When Cancel
                ClearPedTasks(ped)
                TriggerEvent('QBCore:Notify', Lang:t('error.canceled'), 'error')
            end)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if IsLawEnforcement(PlayerData) then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for _, v in pairs(result) do
                            QBCore.Functions.Notify(''..v..'')
                        end
                    end
                end, playerId)
            else
                QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
            end
        end
    end)
end)

RegisterNetEvent("police:client:VehicleMenuHeader", function (data)
    MenuGarage(data.currentSelection)
    currentGarage = data.currentSelection
end)


RegisterNetEvent("police:client:ImpoundMenuHeader", function (data)
    MenuImpound(data.currentSelection)
    currentGarage = data.currentSelection
end)

RegisterNetEvent('police:client:TakeOutImpound', function(data)
    if inImpound then
        local vehicle = data.vehicle
        TakeOutImpound(vehicle)
    end
end)

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    if inGarage then
        local vehicle = data.vehicle
        TakeOutVehicle(vehicle)
    end
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data.currentEvidence
    local pos = GetEntityCoords(PlayerPedId())
    local dept = Config.Departments[currentEvidence[1]]
    local station = dept.Stations[currentEvidence[2]]
    local takeLoc = station.Evidence.Coords

    if not takeLoc then return end

    if #(pos - takeLoc) <= 1.0 then
        local drawer = exports['qb-input']:ShowInput({
            header = Lang:t('info.evidence_stash', {value = dept.PlainText .. " Station #" .. currentEvidence[2]}),
            submitText = "open",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = Lang:t('info.slot')
                }
            }
        })
        if drawer then
            if not drawer.slot then return end
            TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = dept.PlainText .. " Station #" .. currentEvidence[2], value2 = drawer.slot}), {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = dept.PlainText .. " Station #" .. currentEvidence[2], value2 = drawer.slot}))
        end
    else
        exports['qb-menu']:closeMenu()
    end
end)

-- Toggle Duty in an event.
RegisterNetEvent('qb-policejob:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        QBCore.Functions.Notify(Lang:t("error.none_nearby"), "error")
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    local authorizedItems = {
        label = Lang:t('menu.pol_armory'),
        slots = 30,
        items = {}
    }
    local index = 1
    local Station = GetNearestStation(GetDeptConfig().PlainText)
    local plrGradeLevel = QBCore.Functions.GetPlayerData().job.grade.level
    for _, armoryItem in pairs(Station.Armory.Items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == plrGradeLevel then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
end)

RegisterNetEvent('qb-police:client:spawnHelicopter', function(k)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    else
        local coords = Config.Locations["helicopter"][k]
        if not coords then coords = GetEntityCoords(PlayerPedId()) end
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            SetVehicleLivery(veh , 0)
            SetVehicleMod(veh, 0, 48)
            SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, GetDeptConfig().Helicopter_Model, coords, true)
    end
end)

-- Threads

if Config.UseTarget then
    CreateThread(function()
        -- Toggle Duty
        for d,dept in pairs(Config.Departments) do
            for s,station in pairs(dept.Stations) do
                local v = station.Duty
                exports['qb-target']:AddBoxZone("PoliceDuty_"..(d .. s), vector3(v.x, v.y, v.z), 1, 1, {
                    name = "PoliceDuty_"..(d .. s),
                    heading = 11,
                    debugPoly = false,
                    minZ = v.z - 1,
                    maxZ = v.z + 1,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "qb-policejob:ToggleDuty",
                            icon = "fas fa-sign-in-alt",
                            label = "Sign In",
                            job = string.lower(d)
                        },
                    },
                    distance = 1.5
                })
            end
        end
    end)

else
    -- Toggle Duty
    local dutyZones = {}
    for d,dept in pairs(Config.Departments) do
        for s,station in pairs(dept.Stations) do
            local v = station.Duty
            dutyZones[#dutyZones+1] = BoxZone:Create(
                vector3(vector3(v.x, v.y, v.z)), 1.75, 1, {
                name="box_zone",
                debugPoly = false,
                minZ = v.z - 1,
                maxZ = v.z + 1,
            })
        end
    end

    local dutyCombo = ComboZone:Create(dutyZones, {name = "dutyCombo", debugPoly = false})
    dutyCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inDuty = true
            if not isOnDuty() then
                exports['qb-core']:DrawText(Lang:t('info.on_duty'),'left')
            else
                exports['qb-core']:DrawText(Lang:t('info.off_duty'),'left')
            end
        else
            inDuty = false
            exports['qb-core']:HideText()
        end
    end)

    -- Toggle Duty Thread
    CreateThread(function ()
        Wait(1000)
        while true do
            local sleep = 1000
            if inDuty and IsLawEnforcement() then
                sleep = 5
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("police:server:UpdateCurrentCops")
                    TriggerServerEvent("QBCore:ToggleDuty")
                    TriggerServerEvent("police:server:UpdateBlips")
                end
            end
            Wait(sleep)
        end
    end)
end

CreateThread(function()
    -- Evidence Storage
    local evidenceZones = {}
    for _,dept in pairs(Config.Departments) do
        for _,station in pairs(dept.Stations) do
            local v = station.Evidence.Coords
            evidenceZones[#evidenceZones+1] = BoxZone:Create(
                vector3(vector3(v.x, v.y, v.z)), 2, 1, {
                name="box_zone",
                debugPoly = false,
                minZ = v.z - 1,
                maxZ = v.z + 1,
            })
        end
    end

    local evidenceCombo = ComboZone:Create(evidenceZones, {name = "evidenceCombo", debugPoly = false})
    evidenceCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            if IsLawEnforcement() and isOnDuty() then
                local currentEvidence = {}
                local pos = GetEntityCoords(PlayerPedId())

                for d,dept in pairs(Config.Departments) do
                    for s,station in pairs(dept.Stations) do
                        local v = station.Evidence.Coords
                        if #(pos - v) < 2 then
                            currentEvidence = {d, s}
                        end
                    end
                end
                exports['qb-menu']:showHeader({
                    {
                        header = Lang:t('info.evidence_stash', {value = GetDeptConfig().PlainText .. " Station #" .. currentEvidence[2]}),
                        params = {
                            event = 'police:client:EvidenceStashDrawer',
                            args = {
                                currentEvidence = currentEvidence
                            }
                        }
                    }
                })
            end
        else
            exports['qb-menu']:closeMenu()
        end
    end)

    -- Personal Stash
    local stashZones = {}
    for _, v in pairs(Config.Locations["stash"]) do
        stashZones[#stashZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local stashCombo = ComboZone:Create(stashZones, {name = "stashCombo", debugPoly = false})
    stashCombo:onPlayerInOut(function(isPointInside, _, _)
        if isPointInside then
            inStash = true
            exports['qb-core']:DrawText(Lang:t('info.stash_enter'), 'left')
        else
            exports['qb-core']:HideText()
            inStash = false
        end
    end)

    -- Police Trash
    local trashZones = {}
    for _, v in pairs(Config.Locations["trash"]) do
        trashZones[#trashZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1, 1.75, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local trashCombo = ComboZone:Create(trashZones, {name = "trashCombo", debugPoly = false})
    trashCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inTrash = true
            if isOnDuty() then
                exports['qb-core']:DrawText(Lang:t('info.trash_enter'),'left')
            end
        else
            inTrash = false
            exports['qb-core']:HideText()
        end
    end)

    -- Fingerprints
    local fingerprintZones = {}
    for _, v in pairs(Config.Locations["fingerprint"]) do
        fingerprintZones[#fingerprintZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 2, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local fingerprintCombo = ComboZone:Create(fingerprintZones, {name = "fingerprintCombo", debugPoly = false})
    fingerprintCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inFingerprint = true
            if isOnDuty() then
                exports['qb-core']:DrawText(Lang:t('info.scan_fingerprint'),'left')
            end
        else
            inFingerprint = false
            exports['qb-core']:HideText()
        end
    end)

    -- Armoury
    local armouryZones = {}
    for _,dept in pairs(Config.Departments) do
        for _,station in pairs(dept.Stations) do
            local v = station.Armory.Coords
            if v ~= nil then
                armouryZones[#armouryZones+1] = BoxZone:Create(
                    vector3(vector3(v.x, v.y, v.z)), 5, 1, {
                    name="box_zone",
                    debugPoly = false,
                    minZ = v.z - 1,
                    maxZ = v.z + 1,
                })
            end
        end
    end

    local armouryCombo = ComboZone:Create(armouryZones, {name = "armouryCombo", debugPoly = false})
    armouryCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inAmoury = true
            if isOnDuty() then
                exports['qb-core']:DrawText(Lang:t('info.enter_armory'),'left')
            end
        else
            inAmoury = false
            exports['qb-core']:HideText()
        end
    end)

    -- Helicopter
    local helicopterZones = {}
    for _, v in pairs(Config.Locations["helicopter"]) do
        helicopterZones[#helicopterZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 10, 10, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local helicopterCombo = ComboZone:Create(helicopterZones, {name = "helicopterCombo", debugPoly = false})
    helicopterCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inHelicopter = true
            if isOnDuty() then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:HideText()
                    exports['qb-core']:DrawText(Lang:t('info.store_heli'), 'left')
                else
                    exports['qb-core']:DrawText(Lang:t('info.take_heli'), 'left')
                end
            end
        else
            inHelicopter = false
            exports['qb-core']:HideText()
        end
    end)

    -- Police Impound
    local impoundZones = {}
    for _, v in pairs(Config.Locations["impound"]) do
        impoundZones[#impoundZones+1] = BoxZone:Create(
            vector3(v.x, v.y, v.z), 1, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
            heading = 180,
        })
    end

    local impoundCombo = ComboZone:Create(impoundZones, {name = "impoundCombo", debugPoly = false})
    impoundCombo:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inImpound = true
            if isOnDuty() then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t('info.impound_veh'), 'left')
                else
                    local currentSelection = 0

                    for k, v in pairs(Config.Locations["impound"]) do
                        if #(point - vector3(v.x, v.y, v.z)) < 4 then
                            currentSelection = k
                        end
                    end
                    exports['qb-menu']:showHeader({
                        {
                            header = Lang:t('menu.pol_impound'),
                            params = {
                                event = 'police:client:ImpoundMenuHeader',
                                args = {
                                    currentSelection = currentSelection,
                                }
                            }
                        }
                    })
                end
            end
        else
            inImpound = false
            exports['qb-menu']:closeMenu()
            exports['qb-core']:HideText()
        end
    end)

    -- Police Garage
    local garageZones = {}
    for _,dept in pairs(Config.Departments) do
        for _,station in pairs(dept.Stations) do
            local v = station.VehicleGarage

            garageZones[#garageZones+1] = BoxZone:Create(
                vector3(v.x, v.y, v.z), 3, 3, {
                name="box_zone",
                debugPoly = false,
                minZ = v.z - 1,
                maxZ = v.z + 1,
            })
        end
    end

    local garageCombo = ComboZone:Create(garageZones, {name = "garageCombo", debugPoly = false})
    garageCombo:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inGarage = true
            if isOnDuty() and IsLawEnforcement() then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t('info.store_veh'), 'left')
                else
                    local currentSelection = {}

                    for deptName, dept in pairs(Config.Departments) do
                        for stationnum,station in pairs(dept.Stations) do
                            local v = station.VehicleGarage
                            if #(point - vector3(v.x, v.y, v.z)) < 4 then
                                currentSelection = {deptName, stationnum}
                            end
                        end
                    end
                    exports['qb-menu']:showHeader({
                        {
                            header = Lang:t('menu.pol_garage'),
                            params = {
                                event = 'police:client:VehicleMenuHeader',
                                args = {
                                    currentSelection = currentSelection,
                                }
                            }
                        }
                    })
                end
            end
        else
            inGarage = false
            exports['qb-menu']:closeMenu()
            exports['qb-core']:HideText()
        end
    end)
end)

-- Personal Stash Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inStash and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Trash Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inTrash and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
                    maxweight = 4000000,
                    slots = 300,
                })
                TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Fingerprint Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inFingerprint and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-police:client:scanFingerPrint")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Armoury Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inAmoury and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-police:client:openArmoury")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Helicopter Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inHelicopter and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsControlJustReleased(0, 38) then
                TriggerEvent("qb-police:client:spawnHelicopter")
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Impound Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inImpound and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if IsControlJustReleased(0, 38) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                end
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)

-- Police Garage Thread
CreateThread(function ()
    Wait(1000)
    while true do
        local sleep = 1000
        if inGarage and IsLawEnforcement() then
            if isOnDuty() then sleep = 5 end
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if IsControlJustReleased(0, 38) then
                    local veh = GetVehiclePedIsIn(PlayerPedId())

                    TriggerServerEvent("cpolice:server:ReturnVehicle", GetEntityModel(veh), GetDeptConfig())

                    QBCore.Functions.DeleteVehicle(veh)
                end
            end
        else
            sleep = 1000
        end
        Wait(sleep)
    end
end)
