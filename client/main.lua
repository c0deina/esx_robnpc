ESX              = nil
local PlayerData = {}

local robbed = false
local timeToWait = math.random(60000,1800000)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0, 38) then
			local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
			if aiming then
			
			local pP = GetPlayerPed(-1)
			local pCoords = GetEntityCoords(pP, true)
			local tCoords = GetEntityCoords(targetPed, true)
			
			local dict = "random@mugging3"
			RequestAnimDict(dict)
			while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
			end
			
			Citizen.Trace('Aiming')
				if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
				Citizen.Trace('Exists')
				-- LoadAnimationDictionary("random@mugging3")
					if IsPedDeadOrDying(targetPed, true) then
						ESX.ShowNotification("The guy you're robbing is dead")
						else if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true) < 3 then
						TaskPlayAnim(targetPed, "random@mugging3", "handsup_standing_base", 8.0, -8, .01, 49, 0, 0, 0, 0)
						FreezeEntityPosition(targetPed, true)
						robbed = true
						ESX.ShowNotification("You've been given money.")
						Citizen.Wait(10000)
						TriggerServerEvent('esx_robnpc:giveMoney')
						FreezeEntityPosition(targetPed, false)
						Citizen.Wait(timeToWait)
						robbed = false
						-- DeletePed(targetPed)
						end
					end
				end
			end
		end
	end
end)