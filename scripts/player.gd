class_name Player extends Node2D

@export var speed = 200
@export var destination := Vector2.ZERO

func _process ( delta: float ) -> void:
	if position != destination:
		position = position.move_toward( destination,  speed * delta )
