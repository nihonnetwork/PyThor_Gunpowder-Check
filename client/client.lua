local Core = exports.vorp_core:GetCore()
local progressbar = exports.vorp_progressbar:initiate()

local rn = GetCurrentResourceName()
if rn ~= "PyThor_Gunpowder-Check" then
    print("Please rename the resource to the original name")
    StopResource(GetCurrentResourceName())
end

-- events
RegisterNetEvent("GP:CheckJob")
RegisterNetEvent("GP:CheckJobResult")

-- Decorators
DecorRegister("HasShot", 2)

function Dev(...)
    if Config.DevMode then
        print(...)
    end
end

-- global vars
local IsLaw = false

local animDict = "script_amb@stores@store_waist_stern_guy"
local animName = "base"
RequestAnimDict(animDict)
while not HasAnimDictLoaded(animDict) do Citizen.Wait(100) end

while not LocalPlayer.state.IsInSession do
    Wait(5000)
end

TriggerServerEvent("GP:CheckJob", PlayerPedId())
AddEventHandler("GP:CheckJobResult", function(is_law)
    if not Config.JobsAllowed then
        IsLaw = true
    else
        IsLaw = is_law
    end
end)

-- checking command
RegisterCommand(Config.command, function(source, args)
    local targetId = tonumber(args[1])

    if not IsLaw then
        Core.NotifyObjective("Not allowed", 4000)
        return
    end

    if not targetId then
        Dev("Usage: /gp [playerID]")
        return
    end

    -- get the player id from command
    local playerId = GetPlayerServerId(PlayerId())
    local targetPed = nil

    if targetId == playerId then
        targetPed = PlayerPedId()
    else
        targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    end

    if targetPed and DoesEntityExist(targetPed) then
        TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, 5000, 0, 0, false, false, false)
        progressbar.start("Checking gunpowder", 5000, function()
            if DecorExistOn(targetPed, "HasShot") and DecorGetBool(targetPed, "HasShot") then
                Core.NotifyObjective("This person " .. " has fired a weapon recently!", 5000)
            else
                Core.NotifyObjective("This person " .. " is clean.", 5000)
            end
        end, 'innercircle')
    else
        Core.NotifyObjective("Player not found!", 4000)
    end
end, false)

local lassoWeapons = {
    0x7A8A724A,
    0x7BBD1FF6,
    0xb5fd67cd,
    0x791bbd2c,
    -2002235300
}

local function isWeaponLasso(weaponHash)
    for _, lassoHash in ipairs(lassoWeapons) do
        if weaponHash == lassoHash then
            return true
        end
    end
    return false
end

-- apply GP on someone that shot
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        if IsPedShooting(player) then
            local _, weaponHash = GetCurrentPedWeapon(player, true)
            Dev(weaponHash)
            if not isWeaponLasso(weaponHash) then
                Dev("Player shot a weapon (not lasso)")
                DecorSetBool(player, "HasShot", true)

                Core.NotifyRightTip("You got gunpowder residue on you.", 4000)

                local IsInWater = IsEntityInWater(player)
                local timeLeft = Config.TimeToExpire

                while timeLeft > 0 and not IsInWater do
                    Wait(1000)
                    timeLeft = timeLeft - 1000
                    Dev("Time left: " .. timeLeft / 1000)
                end

                Dev("Time expired or player in water, resetting HasShot")
                DecorSetBool(player, "HasShot", false)
            else
                Dev("Player used lasso or bow, ignoring")
            end
        end
    end
end)
