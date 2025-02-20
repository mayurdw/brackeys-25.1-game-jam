extends Control

@onready var containers : Array [ BoxContainer ] = [ $"Center Right Container/Center Right", $"Center Left Container/Center Left", $"Bottom Container/Bottom Left"]

func add_new_box ( box : Box ) -> void:
	_add_to_container( box )
	
func get_list_of_boxes() -> Array[ Box ]:
	var boxes : Array [ Box ] = []
	
	for container in containers:
		for box in container.get_children( false ):
			if box is Box:
				boxes.append ( box )
	
	return boxes

func _sort_by_children_count ( a : BoxContainer, b : BoxContainer ) -> bool:
	return a.get_child_count() < b.get_child_count()

func _add_to_container ( box : Box ) -> void:
	containers.sort_custom( _sort_by_children_count )
	containers[0].add_child( box )
