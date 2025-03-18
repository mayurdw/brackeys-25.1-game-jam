extends Control

@onready var manager: Node2D = $Manager
@onready var start: TypingBox = $CenterContainer/MarginContainer/VBoxContainer/Menu/Start
@onready var credits: TypingBox = $CenterContainer/MarginContainer/VBoxContainer/Menu/Credits
@onready var quit: TypingBox = $CenterContainer/MarginContainer/VBoxContainer/Menu/Quit
@onready var leaderboard: TypingBox = $CenterContainer/MarginContainer/VBoxContainer/Menu/Leaderboard
@onready var instructions: Panel = $Instructions

@export var startText = "start"
@export var creditsText = "credits"
@export var leaderboardText = "leaderboards"
@export var quitText = "quit"

var instructions_hidden = false

func _ready() -> void:
	start.set_box_text( startText )
	credits.set_box_text( creditsText )
	leaderboard.set_box_text( leaderboardText )
	quit.set_box_text( quitText )
	var words: Array [ TypingBox ] = [ start, credits, leaderboard, quit ]
	manager.set_initial_list_of_words( words )


func on_word_selected( word: TypingBox ) -> void:
	pass

func on_word_typed(word: TypingBox) -> void:
	print ( "Word typed = " + str ( word.box_text ) )
	if creditsText == word.box_text:
		SceneTransition.change_to_scene( "res://scenes/credits.tscn" )
	elif startText == word.box_text:
		if GameManager.has_shown_dialogue:
			SceneTransition.change_to_scene( "res://scenes/level_1.tscn" )
		else:
			SceneTransition.change_to_scene( "res://scenes/dialogue_scene.tscn" )
	elif leaderboardText == word.box_text:
		SceneTransition.change_to_scene( "res://scenes/leaderboards.tscn" )
	else:
		get_tree().quit()


func _mouse_input_detected() -> void:
	instructions_hidden = not instructions_hidden
	instructions.visible = instructions_hidden

func _escape_pressed() -> void:
	if instructions_hidden:
		_mouse_input_detected()
	else:
		get_tree().quit()


func _on_start_menu_music_finished() -> void:
	$"Start Menu Music".play()
