ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)


local display = false

RegisterCommand("mesai", function()
    SetDisplay(not display)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNetEvent("nrb-duty:mesaigir")
AddEventHandler("nrb-duty:mesaigir", function()
	local player = PlayerPedId()
    local job = ESX.PlayerData.job.name

    if job == 'police' or job == 'ambulance' then
        exports['mythic_notify']:SendAlert('error', 'Zaten mesaidesin!', 3000)
        return
    end

    if job == 'offpolice' or job == 'offambulance' then
        local playercoords = GetEntityCoords(player)
        local job = string.sub(job, 4)
        local jobcoords = Config[job].coords
		local distance = #(playercoords - jobcoords)
            TriggerServerEvent('nrb-duty:mesaigiris')
    end
end)

RegisterNetEvent("nrb-duty:mesaicik")
AddEventHandler("nrb-duty:mesaicik", function()
    local player = PlayerPedId()
    local job = ESX.PlayerData.job.name

    if job == 'offpolice' or job == 'offambulance' then
        exports['mythic_notify']:SendAlert('error', 'Zaten mesaide değilsin!', 3000)
        return
    end

    if job == 'police' or job == 'ambulance' then
        local playercoords = GetEntityCoords(player)
        local jobcoords = Config[job].coords
        local distance = #(playercoords - jobcoords)
            TriggerServerEvent('nrb-duty:mesaicikis')
    end
end)

RegisterNUICallback('close', function()
  SetNuiFocus(false, false)
end)

RegisterNUICallback('Mesaigir', function()
    TriggerServerEvent('nrb-duty:mesaigiris')
end)

RegisterNUICallback('Mesaicik', function()
    TriggerServerEvent('nrb-duty:mesaicikis')
end)