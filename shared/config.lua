--██╗░░██╗░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗
--╚██╗██╔╝██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
--░╚███╔╝░╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░
--░██╔██╗░░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗
--██╔╝╚██╗██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝
--╚═╝░░╚═╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░
-- support: https://discord.gg/N74Yuq9ARQ

Config = {}

Config.Framework = 'ESX' -- 'ESX' or 'QB'

Config.EnableDealer = true -- if u want to enable the dealer leave true, if u want to disable it set it to false
Config.LockpickPrice = 500  -- Price of the lockpick

Config.DealerPed = {
    model = 's_m_y_dealer_01',  -- model of the ped if u want to change it choose it from here: https://docs.fivem.net/docs/game-references/ped-models/
    coords = vector3(-1231.8174, 389.0809, 75.5330),  -- coords location of the ped
    heading = 34.0, -- heading of the ped
}

Config.LockpickItem = 'lockpick'  -- name of the lockpick item

Config.MinigameDifficulty = 'easy'  -- difficulty lockpicking choose: easy = 90% chance , medium = 70% chance ,hard= = 50% chance

Config.Locks = { -- Locks
    {name = 'Basic Lock', minigame = 'easy', successRate = 90}, -- 90% chance
    {name = 'Advanced Lock', minigame = 'medium', successRate = 70}, -- 70% chance
    {name = 'Expert Lock', minigame = 'hard', successRate = 50}, -- 50% chance
}

-- Locale

-- Notifications
Config.SuccessfulyTitle = "Successfully"
Config.SuccessfullyDesc = "You have successfully picked the lock!"
Config.LockpickingFailed = "Lockpicking Failed"
Config.LockpickingFailedDesc = "You failed to pick the lock and the lockpick broke!"

-- Menu
Config.Lockpick = "Lockpick"
Config.LockpickTheVehicle = "Lockpick Vehicle"
Config.LockpickDealer = "Lockpick Dealer"
Config.BuyLockpick = "Buy Lockpick"
Config.Price = "Price: $"

-- Notify
Config.Nolockpicktitle = "No Lockpick"
Config.Nolockpickdesc = "You don't have a lockpick!"
Config.Cant = "You can't Lockpick"
Config.CantDesc = "You cannot lockpick a vehicle while inside it!"
Config.PurchaseTitle = "Purchase"
Config.BoughtLockpick = "You bought a lockpick"
Config.NotEnoughMoney = "You don't have enough money!"
Config.NotEnoughMoneyDesc = "You do not have enough money to buy a lockpick"