class_name LevelData extends Node

var tasks : Array [ Task ]
@export var words : Array [ String ]
@export var _inter_task_timer : int = 10 : get = get_interval_time
@export var current_index : int = 0

func get_interval_time() -> int:
	_inter_task_timer = clamp( _inter_task_timer - current_index * 2, 2, 5 )
	return _inter_task_timer
	
func are_there_more_tasks() -> bool:
	return current_index < tasks.size()

func next_task() -> Task:
	var task := tasks [ current_index ]
	current_index += 1
	return task

func _ready() -> void:
	var index := 0
	tasks.resize( words.size() )
	for word in words:
		var task = Task.new()
		task.task_name = word
		tasks[index] = task
		index += 1
