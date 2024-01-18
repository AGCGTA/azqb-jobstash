local QBCore = exports['qb-core']:GetCoreObject()

local function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    if GetConvar('qb_locale', 'en') == 'en' then
        SetTextFont(4)
    else
        SetTextFont(1)
    end
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        local sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local pos = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.Locations) do
                local distance = #(pos - Config.Locations[k].coords)
                if distance < 10 then
                    if distance < 1.5 then
                        sleep = 0
                        DrawText3Ds(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z, Lang:t('interaction.openstash'))
                        if IsControlJustPressed(0, 38) then
                            QBCore.Functions.TriggerCallback('azqb-jobstash:server:getPlayer', function(player)
                                local job = player.PlayerData.job
                                if job.name == Config.Locations[k].job then
                                    options = {
                                        maxweight = 5000000,
                                    }
                                    TriggerServerEvent('inventory:server:OpenInventory', 'stash', k, options)
                                    TriggerEvent('inventory:client:SetCurrentStash', k)
                                else
                                    QBCore.Functions.Notify(Lang:t('error.nodutyjob'), 'error')
                                end
                                sleep = 100
                            end)
                        end
                    end
                    break
                end
            end
        end
        Wait(sleep)
    end
end)