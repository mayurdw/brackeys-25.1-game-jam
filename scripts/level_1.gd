extends Node2D

@export var manager: Node2D
@export var task_manager: Node2D
@onready var hud: Control = $HUD


var time_elapsed := 0.0
var time_string := ""
var is_counting = true

func _process( delta: float ) -> void:
	if is_counting:
		time_elapsed += delta
		var minutes = time_elapsed / 60
		var seconds = fmod(time_elapsed, 60)
		var milliseconds = fmod(time_elapsed, 1) * 100
		
		time_string = "%02d : %02d : %02d" % [ minutes, seconds, milliseconds ]
		hud.set_elapsed_time ( time_string )

func on_word_selected ( word: TypingBox ) -> void:
	task_manager.on_word_selected( word )

func on_word_typed ( word: TypingBox ) -> void:
	task_manager.on_task_completed( word )

func _on_task_manager_new_word_added( word: TypingBox ) -> void:
	manager.append_new_word ( word )

func _game_completed() -> void:
	if manager.remaining_words() == 0:
		is_counting = false
		GameManager.on_game_completed( time_string, time_elapsed )


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play() 
