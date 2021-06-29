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

			table.insert(playerList, {
				source = src,
				id = r.id,
				nome = name,
				ping = GetPlayerPing(src)
			})
		end
	end)
end)

AddEventHandler('playerDropped', function(source, reason)
	for k, v in pairs(playerList) do
		if v.source == source then
			table.remove(playerList[k])
		end
	end
end)

-- [[ Threads ]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		for k, v in pairs(playerList) do
			playerList[k].ping = GetPlayerPing(v.source)
		end

		TriggerClientEvent('client:updateScoreboard', -1, playerList)
	end
end)
