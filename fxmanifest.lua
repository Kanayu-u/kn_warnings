fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'kn_warnings'
author 'Kanayu_u'
description 'On-screen warning overlays for restricted vehicles and weapons'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/vehicle.lua',
    'client/weapon.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
}
