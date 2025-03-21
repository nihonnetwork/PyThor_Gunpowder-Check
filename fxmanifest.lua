fx_version 'cerulean'
game { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

name 'PyThor_Gunpowder-Check'
author 'PyThor'
description 'RedM script to check gunpowder'
lua54 'yes'

shared_scripts { 'config.lua' }

client_script { 'client/client.lua' }

server_scripts { 'server/server.lua' }

version '1.1'
vorp_checker 'yes'
vorp_name '^5PyThor_Gunpowder-Check ^4version Check^3'
vorp_github 'https://github.com/PyThor97/PyThor_Gunpowder-Check'
