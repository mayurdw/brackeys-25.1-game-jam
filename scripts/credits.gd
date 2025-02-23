extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released() and event.keycode == KEY_ESCAPE:
		SceneTransition.change_to_scene( "res://scenes/start_menu.tscn" )
