Config = {}

--To get server and client prints, turn off on live server
Config.DevMode = true

--The command to use
Config.Command = "gunpowder"

--Which jobs are allowed to use the command, or false
Config.JobsAllowed = { "lawman", "Sheriff", "Marshal" }

--How long will the gunpowder stay on a player in ms (now it's 15 sec)
Config.DefaultTimeToExpire = 15000

--Weapons that don't leave gunpowder residue (lassos, bows, etc)
Config.WhitelistWeapons = {
    0x7A8A724A,  -- Lasso
    0x7BBD1FF6,  -- Reinforced Lasso
    0xb5fd67cd,  -- Bow
    0x791bbd2c,  -- Improved Bow
    -2002235300  -- Outro
}

--Different expiration times for specific weapons (in ms)
Config.WeaponExpireTimes = {
    -- Example: [weapon_hash] = time_in_ms
    [0x169F59F7] = 30000,  -- Revolver
    [0x22D8FE39] = 45000,  -- Rifle
    -- Add more weapons as needed
}

--Number of times a player needs to wash to remove gunpowder
Config.WashesToClean = 1

--Different wash requirements for specific weapons
Config.WeaponWashRequirements = {
    -- Example: [weapon_hash] = washes_needed
    [0x169F59F7] = 2,  -- Revolver requires 2 washes
    [0x22D8FE39] = 3,  -- Rifle requires 3 washes
    -- Add more weapons as needed
}