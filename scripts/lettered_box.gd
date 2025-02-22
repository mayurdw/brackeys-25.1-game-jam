class_name Box extends Control

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@export var task : Task
@onready var box: PanelContainer = $Box

signal task_expired

func _ready() -> void:
	box.set_box_text( task.task_name )
	progress_bar.max_value = task.task_timer_secs
	progress_bar.value = task.task_timer_secs
	timer.wait_time = task.task_timer_secs
	timer.start()

func _process(delta: float) -> void:
	progress_bar.value = timer.time_left

func word_typed () -> void:
	queue_free ()
	
func selected_count ( length: int ) -> void:
	box.selected_count ( length )

func reset_count () -> void:
	box.reset_count()

func _on_timer_timeout() -> void:
	print( "Task Expired with text = " + task.task_name )
	task_expired.emit()
	
func get_typing_box() -> TypingBox:
	return box
