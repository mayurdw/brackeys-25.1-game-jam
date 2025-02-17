class_name Box extends Node2D

@export var box_word: String
@export var highlight_color := Color.BLACK
@onready var label := $Sprite2D/Control/Label

func _ready() -> void:
	label.text = box_word

func word_typed () -> void:
	queue_free ()
	
func selected_count ( length: int ) -> void:
	label.text = ""
	label.push_color ( highlight_color )
	label.append_text ( box_word.substr( 0, length ) )
	label.pop()
	label.append_text ( box_word.substr( length ) )
