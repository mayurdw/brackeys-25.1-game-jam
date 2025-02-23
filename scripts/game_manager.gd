extends Node

var game_over = false
var game_time_in_float: float = 0.00
var game_time := "0 : 00"
var player_name := ""
var has_shown_dialogue: bool = false

func _ready() -> void:
	SilentWolf.configure({
		"api_key": "QKn6MBVunm9USTlcW6wBa7xL29opw9V32r1sWnUY",
		"game_id": "Production",
		"log_level": 2
		})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn" })

func on_game_over() -> void:
	game_over = true
	SceneTransition.change_to_scene("res://scenes/game_over.tscn")

func on_game_completed( time_elapsed: String, time_elapsed_in_float: float ) -> void:
	print( "Game Completed with time = " + time_elapsed )
	game_time = time_elapsed

func get_scores():
	await SilentWolf.Scores.get_scores().sw_get_scores_complete
