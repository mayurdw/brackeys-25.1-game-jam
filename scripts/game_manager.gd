extends Node

var game_over = false
var game_time: String = "0 : 00"

func on_game_over() -> void:
	game_over = true
	_navigate_to_game_over()

func on_game_completed( time_elapsed: String ) -> void:
	print( "Game Completed with time = " + time_elapsed )
	game_time = time_elapsed
	_navigate_to_game_over()
	
func _navigate_to_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
