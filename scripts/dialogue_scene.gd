extends Node2D

var dialogues := preload( "res://dialogues/start_game.dialogue" )

func _ready() -> void:
	DialogueManager.show_dialogue_balloon( dialogues )
	DialogueManager.dialogue_ended.connect( on_dialogue_end )

func on_dialogue_end ( resource: DialogueResource ) -> void:
	DialogueManager.dialogue_ended.disconnect( on_dialogue_end )
	GameManager.has_shown_dialogue = true 
	SceneTransition.change_to_scene( "res://scenes/level_1.tscn" )
