class_name Player extends Node2D

@export var speed = 200
@export var destination := Vector2.ZERO
@onready var icon: Sprite2D = $Icon

func _process ( delta: float ) -> void:
	if position != destination:
		var new_pos = position.move_toward( destination, speed * delta )
		if new_pos.x > position.x:
			icon.flip_h = false
		else:
			icon.flip_h = true

		position = new_pos
