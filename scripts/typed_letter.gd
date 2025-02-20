extends Control
@onready var box := $"Typed Letter Box"
@onready var timer: Timer = $Timer

var fade_started := false


func letter_typed ( character: String ) -> void:
	timer.stop()
	box.text = character
	timer.start()


func _on_timer_timeout() -> void:
	box.text = ""
