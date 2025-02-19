extends Node

var tasks : Array [ Task ]
var words := [  "hover", "parch", "automa", "cravats", "matronly",
				"lambskin", "empowered", "fascinate", "skylights", "deployment" ]

func _ready() -> void:
	var index := 0
	tasks.resize( 10 )
	tasks.fill ( Task.new() )
	for task in tasks:
		task.task_name = words[index]
		index += 1
