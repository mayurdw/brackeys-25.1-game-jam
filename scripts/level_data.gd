class_name LevelData extends Node

var tasks : Array [ Task ]
@export var words : Array [ String ]
@export var _inter_task_timer : int = 30 : get = _get_interval_time
@export var _tasks_completed : int = 0

func _get_interval_time() -> int:
	_inter_task_timer -= clamp( _tasks_completed * words.size() / 2, 1, _inter_task_timer - 1 )
	return _inter_task_timer
	
func task_completed() -> void:
	_tasks_completed += 1
	
func are_there_more_tasks() -> bool:
	return _tasks_completed < tasks.size()

func next_task() -> Task:
	return tasks[ _tasks_completed ]

func _ready() -> void:
	var index := 0
	tasks.resize( words.size() )
	tasks.fill ( Task.new() )
	for task in tasks:
		task.task_name = words[index]
		index += 1
