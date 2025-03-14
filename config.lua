Config = {}

--To get server and client prints, turn off on live server
Config.DevMode = false

--The command to use
Config.Command = "gunpowder"

--Which jobs are allowed to use the command, or false
Config.JobsAllowed = { "lawman", "Sheriff", "Marshal" }

--How long will the gunpowder stay on a player
Config.TimeToExpire = 10000
