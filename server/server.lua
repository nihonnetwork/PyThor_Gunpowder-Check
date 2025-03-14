local Core = exports.vorp_core:GetCore()

function Dev(...)
    if Config.DevMode then
        print(...)
    end
end

-- events
RegisterNetEvent("GP:CheckJob")
RegisterNetEvent("GP:CheckJobResult")

AddEventHandler("GP:CheckJob", function(src)
    local src = source
    local user = Core.getUser(src)
    if not user then return end
    local character = user.getUsedCharacter
    local player_job = character.job
    local is_law = false

    Dev("player job is: " .. player_job)

    for _, job in ipairs(Config.JobsAllowed) do
        if player_job == job then
            is_law = true
            break
        end
    end
    TriggerClientEvent("GP:CheckJobResult", src, is_law)
end)
