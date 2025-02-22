extends Control

@onready var containers : Array [ BoxContainer ] = [ $"Center Right Container/Center Right", $"Center Left Container/Center Left", $"Bottom Container/Bottom Left"]

var lettered_box = preload( "res://scenes/lettered_box.tscn" )

func add_new_box ( task : Task ) -> TypingBox:
	return _add_to_container( task )
	
func get_list_of_boxes() -> Array[ TypingBox ]:
	var boxes : Array [ TypingBox ] = []
	
	for container in containers:
		for box in container.get_children( false ):
			if box is Box:
				boxes.append ( box.get_typing_box() )
	
	return boxes

func _sort_by_children_count ( a : BoxContainer, b : BoxContainer ) -> bool:
	return a.get_child_count() < b.get_child_count()

func _add_to_container ( task : Task ) -> TypingBox:
	var lettered_box_instance = lettered_box.instantiate()
	
	lettered_box_instance.task = task
	containers.sort_custom( _sort_by_children_count )
	containers[0].add_child( lettered_box_instance )
	
	return lettered_box_instance.get_typing_box()

func word_typed ( typed_box : TypingBox ) -> void:
	typed_box.get_parent().queue_free()
