extends Control

@onready var manager: Node2D = $Manager
@onready var start: TypingBox = $CenterContainer/VBoxContainer/Menu/Start
@onready var credits: TypingBox = $CenterContainer/VBoxContainer/Menu/Credits
@onready var quit: TypingBox = $CenterContainer/VBoxContainer/Menu/Quit

func _ready() -> void:
	start.set_box_text( "Start" )
	credits.set_box_text( "Credits" )
	quit.set_box_text( "Quit" )
	var words: Array [ TypingBox ] = [ start, credits, quit ]
	manager.set_initial_list_of_words( words )


func on_word_selected( word: TypingBox ) -> void:
	print ( "Word selected = " + str ( word.box_text ) )


func on_word_typed(word: TypingBox) -> void:
	print ( "Word typed = " + str ( word.box_text ) )
