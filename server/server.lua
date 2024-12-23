

RegisterNetEvent('website:Addcar')
AddEventHandler('website:Addcar', function(discord, item_id)
    local user_id = getUserIdByDiscordId(discord)
    print(item_id)
    print(user_id)
    addVehicle(user_id, item_id)
end)


-- Homes

RegisterNetEvent('website:AddHome') -- 
AddEventHandler('website:AddHome', function(discord, item_id)
    local user_id = getUserIdByDiscordId(discord)
    local table = {
        price = 0,
        residents = 0,
        chest = 100,

        interior = 'high_01',
        type = 'basic',
        decorations = 0
    }
    quantum.execute('quantum_homes/buyHome', { 
        user_id = user_id, 
        home = item_id, 
        home_owner = 1, 
        garages = 0, 
        tax = 2000, 
        configs = json.encode(table), 
        vip = 0 
    })    
end)


RegisterNetEvent('website:SetVip') 
AddEventHandler('website:SetVip', function(discord,index)
    local user_id = getUserIdByDiscordId(discord)
    quantum.addUserGroup(user_id, 'Vips', index)
end)


RegisterNetEvent('server:getUptime')
AddEventHandler('server:getUptime', function()
    local uptime = GetGameTimer() / 1000 
    local uptimeFormatted = string.format("%02d:%02d:%02d", 
        math.floor(uptime / 3600), 
        math.floor((uptime % 3600) / 60),
        math.floor(uptime % 60)) 
   return uptimeFormatted
end)


RegisterNetEvent('server:getPlayerCount')
AddEventHandler('server:getPlayerCount', function()
    local playerCount = GetNumPlayerIndices() 
   return playerCount
end)



RegisterNetEvent('server:isOnline')
AddEventHandler('server:isOnline', function()
    local isOnline = true 
    if isOnline then
    return 'Online'
    else
        return 'Offline'
    end
end)

