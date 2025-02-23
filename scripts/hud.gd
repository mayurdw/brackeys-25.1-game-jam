extends Control
@onready var typed_letter: Control = $TypedLetter
@onready var time_elapsed: Label = $"MarginContainer/Time Elapsed"

func letter_typed ( letter: String ) -> void:
	typed_letter.letter_typed ( letter )

func set_elapsed_time ( formatted_time: String ) -> void:
	time_elapsed.text = formatted_time
