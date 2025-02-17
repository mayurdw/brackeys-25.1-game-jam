extends Control
@onready var box: Label = $"Typed Letter Box"

func letter_typed ( character: String ) -> void:
	box.text = character
