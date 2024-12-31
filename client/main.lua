local function startLockpicking(vehicle)
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")

    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        Wait(500)
    end

    TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8.0, -1, 1, 0, false, false, false)

    local success = lib.skillCheck({'easy', 'medium', 'hard'})

    ClearPedTasksImmediately(PlayerPedId())

    if success then
 
        local networkId = NetworkGetNetworkIdFromEntity(vehicle)
        if not NetworkHasControlOfEntity(vehicle) then
            NetworkRequestControlOfEntity(vehicle)
            local attempts = 0
            while not NetworkHasControlOfEntity(vehicle) and attempts < 10 do
                Wait(100)
                attempts = attempts + 1
            end
        end

        if NetworkHasControlOfEntity(vehicle) then
            SetVehicleDoorsLocked(vehicle, 1) 
            SetVehicleDoorsLockedForAllPlayers(vehicle, false) 
            SetNetworkIdCanMigrate(networkId, true) 

 
            lib.notify({
                title = Config.SuccessfulyTitle,
                description = Config.SuccessfullyDesc,
                type = 'success'
            })
        else
            lib.notify({
                title = Config.LockpickingFailed,
                description = Config.LockpickingFailedDesc,
                type = 'error'
            })
        end
    else
     
        TriggerServerEvent('x-lockpick:removeLockpick')

        lib.notify({
            title = Config.LockpickingFailed,
            description = Config.LockpickingFailedDesc,
            type = 'error'
        })
    end
end


local function openLockpickVehicleMenu(vehicle)
    lib.registerContext({
        id = 'lockpick_vehicle_menu',
        title = Config.Lockpick,
        options = {
            {
                title = Config.LockpickTheVehicle,
                icon = 'fas fa-tools',
                onSelect = function()
                    startLockpicking(vehicle)
                end,
            }
        }
    })

    lib.showContext('lockpick_vehicle_menu')
end

local function openLockpickMenu()
    lib.registerContext({
        id = 'lockpick_menu',
        title = Config.LockpickDealer,
        options = {
            {
                title = Config.BuyLockpick,
                description = Config.Price .. Config.LockpickPrice,
                icon = 'fas fa-shopping-cart',
                onSelect = function()
                    TriggerServerEvent('x-lockpick:buyLockpick')
                end,
            }
        }
    })

    lib.showContext('lockpick_menu')
end

local function createDealerPed()
    RequestModel(GetHashKey(Config.DealerPed.model))

    while not HasModelLoaded(GetHashKey(Config.DealerPed.model)) do
        Wait(500)
    end

    local dealerPed = CreatePed(4, GetHashKey(Config.DealerPed.model), Config.DealerPed.coords.x, Config.DealerPed.coords.y, Config.DealerPed.coords.z - 1.0, Config.DealerPed.heading, false, true)
    
    SetEntityAsMissionEntity(dealerPed, true, true)
    SetBlockingOfNonTemporaryEvents(dealerPed, true)
    SetPedDiesWhenInjured(dealerPed, false)
    SetPedFleeAttributes(dealerPed, 2, false)
    SetPedCanRagdollFromPlayerImpact(dealerPed, false)
    SetEntityInvincible(dealerPed, true)
    FreezeEntityPosition(dealerPed, true)
    TaskStartScenarioInPlace(dealerPed, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    exports.ox_target:addLocalEntity(dealerPed, {
        {
            name = 'buy_lockpick_menu',
            icon = 'fas fa-tools',
            label = Config.BuyLockpick,
            onSelect = function()
                openLockpickMenu()
            end
        }
    })
end

if Config.EnableDealer then
    createDealerPed()
end


exports.ox_target:addGlobalVehicle({
    {
        name = 'lockpick_vehicle',
        icon = 'fas fa-car-side',
        label = Config.LockpickTheVehicle,
        onSelect = function(data)
            local playerPed = PlayerPedId()
            if not IsPedInAnyVehicle(playerPed, false) then
                if Config.Framework == 'ESX' then
                    ESX = exports["es_extended"]:getSharedObject()
                    ESX.TriggerServerCallback('x-lockpick:hasLockpick', function(hasLockpick)
                        if hasLockpick then
                            local vehicle = data.entity
                            openLockpickVehicleMenu(vehicle)
                        else
                            lib.notify({
                                title = Config.Nolockpicktitle,
                                description = Config.Nolockpickdesc,
                                type = 'error'
                            })
                        end
                    end)
                elseif Config.Framework == 'QB' then
                    QBCore = exports['qb-core']:GetCoreObject()
                    QBCore.Functions.TriggerCallback('x-lockpick:hasLockpick', function(hasLockpick)
                        if hasLockpick then
                            local vehicle = data.entity
                            openLockpickVehicleMenu(vehicle)
                        else
                            lib.notify({
                                title = Config.Nolockpicktitle,
                                description = Config.Nolockpickdesc,
                                type = 'error'
                            })
                        end
                    end)
                end
            else
                lib.notify({
                    title = Config.Cant,
                    description = Config.CantDesc,
                    type = 'error'
                })
            end
        end,
        canInteract = function(entity, distance, coords, name)
            return not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    }
})