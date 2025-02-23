extends Control

var api_fired = false
var api_needed = true

func _process( delta: float ) -> void:
	if api_needed and not api_fired:
		api_fired = true
		await SilentWolf.Scores.get_scores().sw_get_scores_complete
		$"Loading Overlay".visible = false
		api_needed = false
		_create_scoreboard()

func _create_timestamp( time_elapsed: float ) -> String:
	var minutes = time_elapsed / 60
	var seconds = fmod(time_elapsed, 60)
	var milliseconds = fmod(time_elapsed, 1) * 100
		
	return "%02d : %02d : %02d" % [ minutes, seconds, milliseconds ]

func _create_scoreboard() -> void:
	var index := 1
	for score in SilentWolf.Scores.scores:
		var container: HBoxContainer = get_node( "Overlay/CenterContainer/VBoxContainer/HBoxContainer" + str( index ) )
		container.get_child( 1 ).text = score[ "player_name" ]
		container.get_child( 2 ).text = _create_timestamp ( score[ "score" ] )
		index += 1

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released() and event.keycode == KEY_ESCAPE:
		SceneTransition.change_to_scene( "res://scenes/start_menu.tscn" )
