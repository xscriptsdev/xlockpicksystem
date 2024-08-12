fx_version 'cerulean'
game 'gta5'

lua54 'yes'
author 'X SCRIPTS'
description 'Simple Lockpick System'
version '1.0.0'


client_script 'client/main.lua'

server_script 'server/main.lua'

shared_scripts {
    'shared/config.lua',
    '@ox_lib/init.lua'
}
