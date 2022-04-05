fx_version 'adamant'

game 'gta5'

description 'Illegal Storage'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua'
	'client/buttonbar.lua',
	'client/objects.lua',
	'client/main.lua'
}
