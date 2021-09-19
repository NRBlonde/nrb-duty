ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscordems(name, message, color) --EMS LOG
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "NRBlonde Development",
				  ["icon_url"] = "https://cdn.discordapp.com/attachments/708750368762363964/889243822456983593/AAUvwni3iEsJWVZ8_9eU1yWOky3h0V2I25rS1J48yIkNgAs88-c-k-c0x00ffffff-no-rj.jpg"
			  },
		  }
	  }
	PerformHttpRequest("buraya webhook", function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  function sendToDiscordpd(name, message, color) --LSPD LOG
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "NRBlonde Development",
				  ["icon_url"] = "https://cdn.discordapp.com/attachments/708750368762363964/889243822456983593/AAUvwni3iEsJWVZ8_9eU1yWOky3h0V2I25rS1J48yIkNgAs88-c-k-c0x00ffffff-no-rj.jpg"
			  },
		  }
	  }
	PerformHttpRequest("buraya webhook", function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end

  function getid(src)
	local identifier = {}
	local identifiers = {}
	
	identifiers = GetPlayerIdentifiers(src)
	for i = 1, #identifiers do
		if string.match(identifiers[i], "discord:") then
			identifier["discord"] = string.sub(identifiers[i], 9)
			identifier["discord"] = "<@"..identifier["discord"]..">"
		end
		if string.match(identifiers[i], "steam:") then
			identifier["license"] = identifiers[i]
		end
	end
	if identifier["discord"] == nil then
		identifier["discord"] = "Bilinmiyor"
	end
	return identifier
end

RegisterServerEvent('nrb-duty:mesaigiris')
AddEventHandler('nrb-duty:mesaigiris', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
        sendToDiscordpd( "LSPD MESAİ LOG \n Mesai'ye giriş yaptı Oyuncu: "..GetPlayerName(source).." ")
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
        sendToDiscordems( "EMS MESAİ LOG \n Mesai'ye giriş yaptı Oyuncu: "..GetPlayerName(source).." ")
    end
end)

RegisterServerEvent('nrb-duty:mesaicikis')
AddEventHandler('nrb-duty:mesaicikis', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'offpolice' or job == 'offambulance' then 
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Zaten mesaide değilsin!'})
        return
    end

    if job == 'police' then
        xPlayer.setJob('offpolice', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiden çıktın!'})
        sendToDiscordpd( "LSPD MESAİ LOG \n Mesai'den çıkış yaptı Oyuncu: "..GetPlayerName(source).." ")
    elseif job == 'ambulance' then
        xPlayer.setJob('offambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiden çıktın!'})
        sendToDiscordems( "EMS MESAİ LOG \n Mesai'den çıkış yaptı Oyuncu: "..GetPlayerName(source).." ")
    end
end)

AddEventHandler('esx:playerLoaded', function(source)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'police' or job == 'ambulance' then
        xPlayer.setJob('off'..job, grade)
    end
end)
