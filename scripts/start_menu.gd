extends Control

@onready var manager: Node2D = $Manager
@onready var start: TypingBox = $CenterContainer/VBoxContainer/Menu/Start
@onready var credits: TypingBox = $CenterContainer/VBoxContainer/Menu/Credits
@onready var quit: TypingBox = $CenterContainer/VBoxContainer/Menu/Quit

@export var startText = "Start"
@export var creditsText = "Credits"
@export var quitText = "Quit"

func _ready() -> void:
	start.set_box_text( startText )
	credits.set_box_text( creditsText )
	quit.set_box_text( quitText )
	var words: Array [ TypingBox ] = [ start, credits, quit ]
	manager.set_initial_list_of_words( words )


func on_word_selected( word: TypingBox ) -> void:
	pass

func on_word_typed(word: TypingBox) -> void:
	print ( "Word typed = " + str ( word.box_text ) )
	if creditsText == word.box_text:
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
	elif startText == word.box_text:
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
