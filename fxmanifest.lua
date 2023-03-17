fx_version 'cerulean'
game 'gta5'

description 'QB-PoliceJob'
version '1.0.0'

shared_scripts {
    'Core/config.lua',
	'Dept/*.lua',
    '@qb-core/shared/locale.lua',
    'Core/locales/en.lua' -- Change this to your preferred language
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'Core/client/main.lua',
	'Core/client/job.lua',
	'Core/client/camera.lua',
	'Core/client/interactions.lua',
	'Core/client/heli.lua',
	--'client/anpr.lua',
	'Core/client/evidence.lua',
	'Core/client/objects.lua',
	'Core/client/tracker.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'Core/server/server.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/vue.min.js',
	'html/script.js',
	'html/tablet-frame.png',
	'html/fingerprint.png',
	'html/main.css',
	'html/vcr-ocd.ttf'
}

lua54 'yes'