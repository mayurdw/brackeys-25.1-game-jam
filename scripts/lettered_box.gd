class_name Box extends Control

@export var highlight_color := Color.ROYAL_BLUE
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var label: RichTextLabel = $VBoxContainer/PanelContainer/MarginContainer/CenterContainer/Label
@onready var timer: Timer = $Timer

@export_category("Task")
@export var task : Task

func _ready() -> void:
	label.text = task.task_name
	progress_bar.max_value = task.task_timer_secs
	progress_bar.value = task.task_timer_secs
	timer.wait_time = task.task_timer_secs
	timer.start()

func _process(delta: float) -> void:
	progress_bar.value = timer.time_left

func word_typed () -> void:
	queue_free ()
	
func selected_count ( length: int ) -> void:
	label.text = ""
	label.push_color ( highlight_color )
	label.append_text ( task.task_name.substr( 0, length ) )
	label.pop()
	label.append_text ( task.task_name.substr( length ) )

func reset_count () -> void:
	label.text = task.task_name


func _on_timer_timeout() -> void:
	print ( "Task Expired" )
