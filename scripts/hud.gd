extends Control
@onready var typed_letter: Control = $TypedLetter

func letter_typed ( letter: String ) -> void:
	typed_letter.letter_typed ( letter )
