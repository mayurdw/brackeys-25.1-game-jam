extends Node2D

@export var manager: Node2D
@export var task_manager: Node2D

func on_word_selected ( word: TypingBox ) -> void:
	task_manager.on_word_selected( word )

func on_word_typed ( word: TypingBox ) -> void:
	task_manager.on_task_completed( word )

func _on_task_manager_new_word_added( word: TypingBox ) -> void:
	manager.append_new_word ( word )
