ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('x-lockpick:buyLockpick')
AddEventHandler('x-lockpick:buyLockpick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if money >= Config.LockpickPrice then
        xPlayer.removeMoney(Config.LockpickPrice)
        xPlayer.addInventoryItem(Config.LockpickItem, 1)
        TriggerClientEvent('ox_lib:notify', source, {title = Config.PurchaseTitle, description = Config.BoughtLockpick, type = 'success'})
    else
        TriggerClientEvent('ox_lib:notify', source, {title = Config.NotEnoughMoney, description = Config.NotEnoughMoneyDesc, type = 'error'})
    end
end)

ESX.RegisterServerCallback('x-lockpick:hasLockpick', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local hasLockpick = xPlayer.getInventoryItem(Config.LockpickItem).count > 0

  cb(hasLockpick)
end)


RegisterServerEvent('x-lockpick:removeLockpick')
AddEventHandler('x-lockpick:removeLockpick', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.LockpickItem, 1)
end)
