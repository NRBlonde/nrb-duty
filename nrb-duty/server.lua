ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nrb-duty:mesaigiris')
AddEventHandler('nrb-duty:mesaigiris', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiye girdin!'})
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

    if job == 'police' or job == 'ambulance' then
        xPlayer.setJob('off'..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Mesaiden çıktın!'})
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