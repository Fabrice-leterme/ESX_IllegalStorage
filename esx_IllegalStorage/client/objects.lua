objectSpawned = nil
canShowMenu = true


function SpawnObject()
	--777.39135742188, -1275.9583740234, 12.932094573975, 201.02143859863
	ESX.Game.SpawnLocalObject('prop_container_05a', GetEntityCoords(GetPlayerPed(-1)), function(object)
    	buttons = setupScaleform("instructional_buttons")
    	SetEntityAlpha(object, 200)
    	FreezeEntityPosition(object, true)
    	objectSpawned = object
    	local forward = 2
    	local up = 0.0
    	local rotation = 0.0
    	local userCoords = GetEntityCoords(GetPlayerPed(-1))
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward
		local yVector = forward
		local rotate = false
		local placingObject = true;
		canShowMenu = false
    	Citizen.CreateThread(function()
	    	while true do
	        	Citizen.Wait(0)
	        	if placingObject then
		        	DrawScaleformMovieFullscreen(buttons)
		        	DisableControls()
					if IsControlPressed(0, 188) then
						yVector = yVector - 0.01
					end
					if IsControlPressed(0, 187) then
						yVector = yVector + 0.01
					end
					if IsControlPressed(0, 189) then
						xVector = xVector + 0.01
					end
					if IsControlPressed(0, 190) then
						xVector = xVector - 0.01
					end
					if IsControlPressed(0, 14) then
						rotation = rotation - 2
					end
					if IsControlPressed(0, 15) then
						rotation = rotation + 2
					end
					if IsControlJustReleased(0, 202) then
						DeleteObject(object)
						placingObject = false
						canShowMenu = true
					end

					if IsControlJustReleased(0, 191) then
						spawnCoords = GetEntityCoords(object)
						spawnHeading = GetEntityHeading(object)
						DeleteObject(object)
						ESX.Game.SpawnObject('prop_container_05a', spawnCoords, function(object2)
							SetEntityHeading(object2, spawnHeading)
							PlaceObjectOnGroundProperly(object2)
    						print(GetEntityModel(object2), 'Container succesfully placed at ' .. spawnCoords ..'!')
    						FreezeEntityPosition(object2, true)
    						placingObject = false
    						canShowMenu = true
    						TriggerServerEvent('shippingcontainer:savecontainer', tostring(spawnCoords))
						end)
					end

					SetEntityCoords(object, userCoords.x + xVector, userCoords.y + yVector, userCoords.z + up)
					SetEntityHeading(object, rotation)
				end
	    	end
	    end)
	end)
end

-- -23.683891296387, -2420.3371582031, 6.000283241272, 3.1855032444
-- -23.68052, -2417.924, 6

-- -31.40811920166, -2416.1088867188, 5.9999957084656, 276.67047119141
-- -28.98098, -2415.699, 5.999996