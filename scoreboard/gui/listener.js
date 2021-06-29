window.addEventListener('message', (event) => {
	var data = event.data;

	if (data.type == 'scoreboard') {
		if (data.command == 'open') {
			scoreboard.style.display = 'block';
		}
		if (data.command == 'update') {
			var content = "<table>\
				<tr>\
					<th>ID</th>\
					<th>Nome</th>\
					<th>Ping</th>\
				</tr>";

			for (var key in data.data) {
				content = content + "\
					<tr>\
						<th>" + data.data[key].id + "</th>\
						<th>" + data.data[key].nome + "</th>\
						<th>" + data.data[key].ping + " ms</th>\
					</tr>";
			}
			sb_status.innerHTML = 'Adventus RPG - ' + data.data.length + ' players conectados';
			sb_players.innerHTML = content + "</table>";
		}
	}
});

window.addEventListener('keyup', function(event) {
	var which = event.which;

	if (which == 27 && scoreboard.style.display == 'block') {
		scoreboard.style.display = 'none';

		$.post('http://scoreboard/scoreboard:close', JSON.stringify({}));
	}
});
