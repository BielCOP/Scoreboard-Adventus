RegisterNetEvent('client:updateScoreboard')

-- [[ Eventos ]]

AddEventHandler('client:updateScoreboard', function(data)
	SendNUIMessage({
		type = 'scoreboard',
		command = 'update',
		data = data
	})
end)

-- [[ Threads ]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if NetworkIsSessionStarted() then
			local playerid = PlayerId()

			TriggerServerEvent('server:updatePlayerList', GetPlayerName(playerid))
			break
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionActive() then
			if IsControlPressed(0, 303) then -- Tecla U
				SendNUIMessage({
					type = 'scoreboard',
					command = 'open'
				})
				SetNuiFocus(true, true)
			end
		end
	end
end)

-- [[ NUI Callbacks ]]

RegisterNUICallback('scoreboard:close', function()
	SetNuiFocus(false, false)
end)
