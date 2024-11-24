local Framework = nil

if GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == 'started' then
    Framework = exports['es_extended']:getSharedObject()
end

RegisterServerEvent('x-lockpick:buyLockpick', function()
    local src = source
    if Framework then
        if GetResourceState('qb-core') == 'started' then
            local Player = Framework.Functions.GetPlayer(src)
            if Player.Functions.RemoveMoney('cash', Config.LockpickPrice) then
                Player.Functions.AddItem(Config.LockpickItem, 1)
                TriggerClientEvent('ox_lib:notify', src, {title = Config.PurchaseTitle, description = Config.BoughtLockpick, type = 'success'})
            else
                TriggerClientEvent('ox_lib:notify', src, {title = Config.NotEnoughMoney, description = Config.NotEnoughMoneyDesc, type = 'error'})
            end
        elseif GetResourceState('es_extended') == 'started' then
            local xPlayer = Framework.GetPlayerFromId(src)
            if xPlayer.getMoney() >= Config.LockpickPrice then
                xPlayer.removeMoney(Config.LockpickPrice)
                xPlayer.addInventoryItem(Config.LockpickItem, 1)
                TriggerClientEvent('ox_lib:notify', src, {title = Config.PurchaseTitle, description = Config.BoughtLockpick, type = 'success'})
            else
                TriggerClientEvent('ox_lib:notify', src, {title = Config.NotEnoughMoney, description = Config.NotEnoughMoneyDesc, type = 'error'})
            end
        end
    end
end)

RegisterServerEvent('x-lockpick:removeLockpick', function()
    local src = source
    if Framework then
        if GetResourceState('qb-core') == 'started' then
            local Player = Framework.Functions.GetPlayer(src)
            Player.Functions.RemoveItem(Config.LockpickItem, 1)
        elseif GetResourceState('es_extended') == 'started' then
            local xPlayer = Framework.GetPlayerFromId(src)
            xPlayer.removeInventoryItem(Config.LockpickItem, 1)
        end
    end
end)
