quantum.prepare('quantum_homes/getApartamentOwner', 'select * from homes where home like @home and user_id = @user_id and home_owner = 1')
quantum.prepare('quantum_homes/getApartamentOwnerWithoutUser', 'select * from homes where home like @home and home_owner = 1')
quantum.prepare('quantum_homes/apartamentPermissions', 'select * from homes where home like @home AND user_id = @user_id')
quantum.prepare('quantum_homes/getHomeOwner', 'select * from homes where home = @home AND home_owner = 1')
quantum.prepare('quantum_homes/buyHome', 'insert homes (user_id, home, home_owner, garages, tax, configs, vip) values (@user_id, @home, @home_owner, @garages, @tax, @configs, @vip)')
quantum.prepare('quantum_homes/homePermissions', 'select * from homes where home = @home AND user_id = @user_id')
quantum.prepare('quantum_homes/countPermissions', 'select count(*) as qtd from homes where home = @home')
quantum.prepare('quantum_homes/newPermissions', 'insert into homes (user_id, home, home_owner, tax, garages, configs, vip) values (@user_id, @home, @home_owner, @tax, @garages, @configs, @vip)')
quantum.prepare('quantum_homes/removePermissions', 'delete from homes where home = @home and user_id = @user_id')
quantum.prepare('quantum_homes/removeResidents', 'delete from homes where home = @home and home_owner = 0')
quantum.prepare('quantum_homes/updateOwner', 'update homes set user_id = @nuser_id where user_id = @user_id and home = @home')
quantum.prepare('quantum_homes/sellHome', 'delete from homes where home = @home')
quantum.prepare('quantum_homes/selectHomes', 'select * from homes where home = @home')
quantum.prepare('quantum_homes/updateTax', 'update homes set tax = @tax where home = @home')
quantum.prepare('quantum_homes/userList', 'select * from homes where user_id = @user_id and home_owner = 1')
quantum.prepare('quantum_homes/userHomesList', 'select * from homes where user_id = @user_id')
quantum.prepare('quantum_homes/updateConfig', 'update homes set configs = @configs where home = @home')
quantum.prepare('quantum_homes/updateGarages', 'update homes set garages = @garages where home = @home and home_owner = 1')
quantum.prepare('quantum_homes/addGarage', 'insert homes_garages (home, blip, spawn) values (@home, @blip, @spawn)')
quantum.prepare('quantum_homes/permissions', 'select * from homes where home = @home')
quantum.prepare('quantum_homes/getGarage', 'select * from homes_garages where home = @home')
quantum.prepare('quantum_homes/delGarage', 'delete from homes_garages where home = @home')
quantum.prepare('quantum_homes/getHomes', 'select * from homes')
quantum.prepare('quantum_homes/getAllHomesOwner', 'select * from homes where home_owner = 1')
quantum.prepare('quantum_garage/addVehicle', 'insert ignore into user_vehicles (user_id, vehicle, plate, chassis, service, ipva, state, custom) values (@user_id, @vehicle, @plate, @chassis, @service, @ipva, @state, @custom)')
quantum.prepare('quantum_garage/getVehiclePlate', 'select plate from user_vehicles where user_id = @user_id and vehicle = @vehicle')
quantum.prepare('quantum_garage/getVehiclesWithPlate', 'select * from user_vehicles where plate = @plate')
quantum.prepare('quantum_garage/getVehiclesWithChassis', 'select * from user_vehicles where chassis = @chassis')

function getUserIdByDiscordId(discordId)
    local discordIdentifier = 'discord:' .. discordId
    local user_id = nil
    Citizen.CreateThread(function()
        MySQL.Async.fetchScalar('SELECT user_id FROM user_ids WHERE identifier = @identifier', {
            ['@identifier'] = discordIdentifier
        }, function(result)
            user_id = result  
        end)
    end)
    while user_id == nil do
        Citizen.Wait(0)  
    end

    return user_id
end


local idGenerator = function(format)
	local num = {'0','1','2','3','4','5','6','7','8','9'}
	local alg = {'A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local all = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','R','S','T','U','V','W','X','Y','Z'}
	local number = ''
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == 'D' then number = number..num[math.random(#num)]
		elseif char == 'L' then number = number..alg[math.random(#alg)]
		elseif char == 'A' then number = number..all[math.random(#all)]
		else number = number..char end
	end
	return number
end
local forms = {
    plate = 'LLL DLDD',
    chassi = 'AALLLDDLDALDDDDDD'
}

getPlateOwner = function(plate)
	if plate and (plate ~= '') then
		local car = quantum.query('quantum_garage/getVehiclesWithPlate', { plate = plate })[1]
		if (car) then return car.user_id, car.vehicle; end;
	end
end

generatePlate = function()
	local user_id = nil
	local nplate = ''
	repeat
		nplate = idGenerator(forms.plate)
		user_id = getPlateOwner(nplate)
	until not user_id
	return nplate
end
generateChassis = function()
	local user_id = nil
	local nchassi = ''
	repeat
		nchassi = idGenerator(forms.chassi)
		user_id = getChassisOwner(nchassi)
	until not user_id
	return nchassi
end

getChassisOwner = function(chassi)
	if chassi and (chassi ~= '') then
		local car = quantum.query('quantum_garage/getVehiclesWithChassis', { chassis = chassi })[1]
		if (car) then return car.user_id, car.vehicle; end;
	end
end


addVehicle = function(user_id, vehicle, service)
	local query = quantum.query('quantum_garage/getVehiclePlate', { user_id = user_id, vehicle = vehicle })[1]
	if (query) then return; end;
	quantum.execute('quantum_garage/addVehicle', { user_id = user_id, vehicle = vehicle, plate = generatePlate(), chassis = generateChassis(), ipva = os.time(), service = service, state = json.encode({}), custom = json.encode({}) })
end
