extends Control

@onready var menu: Array [ TypingBox ] = [ 
		$"CenterContainer/VBoxContainer/Menu/Back to Menu", 
		$CenterContainer/VBoxContainer/Menu/Leaderboards
	]
@onready var title: Label = $CenterContainer/VBoxContainer/Title
@onready var game_time: Label = $"CenterContainer/VBoxContainer/Game Time"
@onready var manager: Node2D = $Manager

func is_game_over () -> bool:
	return GameManager.game_over

func _ready() -> void:
	menu[0].set_box_text( "Menu" )
	menu[1].set_box_text( "Leaderboards" )
	if not is_game_over():
		title.text = "Game Completed"
		game_time.visible = true
		game_time.text = "Game Time = " + GameManager.game_time
	else:
		game_time.visible = false
	manager.set_initial_list_of_words ( menu )
	_test_get_scores()

func toggle_game_completion_visibility( show: bool ) -> void:
	if show:
		title.text = "Game Completed"
		game_time.text = "Game Time = " + GameManager.game_time
	
	game_time.visible = show

func _test_get_scores() -> void:
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	print("Scores: " + str(sw_result.scores))

func on_word_typed( word: TypingBox ) -> void:
	if "Menu" == word.box_text:
		SceneTransition.change_to_scene( "res://scenes/start_menu.tscn" )
	elif "Leaderboards" == word.box_text:
		SceneTransition.change_to_scene( "res://scenes/leaderboards.tscn" )
