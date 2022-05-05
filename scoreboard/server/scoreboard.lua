RegisterServerEvent('server:updatePlayerList')

-- [[ Variáveis ]]

local playerList = {}

-- [[ Eventos ]]

AddEventHandler('server:updatePlayerList', function(name)
	local src = source

	MySQL.Async.fetchAll('Select * From contas Where nome = @nome', { -- Banco de dados do Adventus
		['@nome'] = name
	}, function(result)
		if result[1] then
			local r = result[1]

			playerList[src] = {
				id = r.id,
				nome = r.nome,
				ping = GetPlayerPing(src)
			}
		end
	end)
end)

AddEventHandler('playerDropped', function(reason)
	local src = source

	for k, v in pairs(playerList) do
		if k == src then
			playerList[k] = nil
		end
	end
end)

-- [[ Threads ]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		for k, v in pairs(playerList) do
			playerList[k].ping = GetPlayerPing(k)
		end

		TriggerClientEvent('client:updateScoreboard', -1, playerList)
	end
end)
