ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('shippingcontainer:createContainer')
AddEventHandler('shippingcontainer:createContainer', function()
	print("creating container")
	SpawnObject()
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		local ped = GetPlayerPed(-1)
    	local pos = GetEntityCoords(ped)

		local closestDistance = -1
		local closestEntity = nil

	    local container = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, GetHashKey('prop_container_05a'), false, false, false)
	    local containerPos = GetEntityCoords(container)
	    local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, containerPos.x, containerPos.y, containerPos.z, true)
	    if dist < 2.7 and canShowMenu then
	        DisplayHelpText("Press ~INPUT_PICKUP~ to access your container.")
	        if IsControlJustPressed(0, 38) then
                openContainerMenu(container)
                ClearPedTasks(ped)
            end
	    end
	end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function openContainerMenu()
	local elements = {}
	table.insert(elements, {label = 'Open inventory', value = 'open'})
	table.insert(elements, {label = 'Upgrade lock', value = 'lockUpgrade'})
	table.insert(elements, {label = 'Destroy', value = 'destroy'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'container', {
		title    = "Container Menu",
		align    = 'bottom',
		elements = elements
		}, function(data, menu)
			menu.close()
			if data.current.value == 'open' then
				print("Trying to open the inventory")
			elseif data.current.value == 'lockUpgrade' then
				print("Trying to upgrade the locks")
			end			
		end, function(data, menu)
			menu.close()
	end)
end

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  print('The resource ' .. resourceName .. ' has been started.')
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  print('The resource ' .. resourceName .. ' was stopped.')
end)



