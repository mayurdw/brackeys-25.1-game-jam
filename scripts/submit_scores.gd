extends Control

@onready var text_edit: TextEdit = $Panel/CenterContainer/VBoxContainer/TextEdit
@onready var loading_overlay: Panel = $"Loading Overlay"

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		if KEY_ENTER == event.keycode:
			GameManager.player_name = text_edit.text.strip_escapes()
			loading_overlay.visible = true
			await SilentWolf.Scores.save_score( GameManager.player_name, GameManager.game_time_in_float ).sw_save_score_complete
			loading_overlay.visible = false
			SceneTransition.change_to_scene( "res://scenes/game_over.tscn" )
		elif KEY_ESCAPE == event.keycode:
			SceneTransition.change_to_scene( "res://scenes/game_over.tscn" )
