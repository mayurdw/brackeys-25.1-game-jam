class_name Box extends Node2D

@export var box_word: String
@onready var label: Label = $Sprite2D/Control/Label

func _ready() -> void:
	label.text = box_word

func word_typed () -> void:
	queue_free ()
