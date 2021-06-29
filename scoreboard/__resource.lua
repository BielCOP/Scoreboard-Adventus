description 'Adventus - Scoreboard'
version '1.0'
ui_page 'gui/index.html'

files {
	'gui/index.html',
	'gui/style.css',
	'gui/listener.js'
}

server_script '@mysql-async/lib/MySQL.lua'

server_script 'server/scoreboard.lua'
client_script 'client/scoreboard.lua'
