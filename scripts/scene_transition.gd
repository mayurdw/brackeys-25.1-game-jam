extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_to_scene( target_scene: String ) -> void:
	animation_player.play( "dissolve" )
	await animation_player.animation_finished
	get_tree().change_scene_to_file( target_scene )
	animation_player.play_backwards( "dissolve" )
