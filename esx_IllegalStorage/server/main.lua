ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('shipping_container', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    print("This is a test")
   -- xPlayer.removeInventoryItem('shipping_container', 1)
   	MySQL.Async.fetchAll('SELECT * FROM `lem_shippingcontainers` WHERE owner = @owner',
	{
		['@owner'] = xPlayer.identifier
	}, function(result)
		if #result > 0 then
			xPlayer.showNotification("You already have a container!")
		else
			TriggerClientEvent('shippingcontainer:createContainer', xPlayer.source)
		end
	end)
end)

RegisterNetEvent('shippingcontainer:savecontainer')
AddEventHandler('shippingcontainer:savecontainer', function(spawnCoords)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('INSERT INTO lem_shippingcontainers (owner, location) VALUES (@owner, @location)', {
		['@location']   = spawnCoords,
		['@owner']  = xPlayer.identifier
		}, function(rowsChanged)
			xPlayer.removeInventoryItem('shipping_container', 1)
	end)
end)

