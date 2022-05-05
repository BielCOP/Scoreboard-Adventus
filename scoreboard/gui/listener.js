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
			var players = 0;
			var scroll = sb_players.scrollTop;

			for (var key in data.data) {
				if (data.data[key]) {
					content = content + "\
						<tr>\
							<td>" + data.data[key].id + "</td>\
							<td>" + data.data[key].nome + "</td>\
							<td>" + data.data[key].ping + " ms</td>\
						</tr>";
					players += 1;
				}
			}
			sb_status.innerHTML = 'Adventus RPG - ' + players + ' players conectados';
			sb_players.innerHTML = content + "</table>";
			sb_players.scrollTop = scroll;
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
