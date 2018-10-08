ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_robnpc:giveMoney')
AddEventHandler('esx_robnpc:giveMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local money = math.random(100,500)
    xPlayer.addMoney(money)
end)