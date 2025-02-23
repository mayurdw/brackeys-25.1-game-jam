extends Control

@onready var back_to_menu: Array [ TypingBox ] = [ $"CenterContainer/VBoxContainer/Menu/Back to Menu" ]
@onready var title: Label = $CenterContainer/VBoxContainer/Title
@onready var game_time: Label = $"CenterContainer/VBoxContainer/Game Time"
@onready var manager: Node2D = $Manager

func is_game_over () -> bool:
	return GameManager.game_over

func _ready() -> void:
	back_to_menu[0].set_box_text( "Menu" )
	manager.set_initial_list_of_words ( back_to_menu )
	if not is_game_over():
		title.text = "Game Completed"
		game_time.visible = true
		game_time.text = "Game Time = " + GameManager.game_time
	else:
		game_time.visible = false
