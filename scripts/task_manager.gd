extends Node2D

@onready var player: Player = $Player
@onready var interval_timer: Timer = $"Interval Timer"

@export var level_tasks : LevelData
@export var task_ui_manager: Control
@export var center_right: Control
@export var center_left: Control
@export var bottom: Control

signal new_word_added ( word: TypingBox )
signal game_completed

func _ready () -> void:
	_on_timer_expiry()
	player.destination = get_viewport_rect().size / 2

func on_task_completed( word: TypingBox ) -> void:
	task_ui_manager.word_typed( word )
	if level_tasks.are_there_more_tasks():
		add_new_task( level_tasks.next_task() )
	else:
		game_completed.emit()

func on_word_selected( box : TypingBox ) -> void:
	_calculate_sprite_position( box )

func _calculate_sprite_position ( box : TypingBox ) -> void:
	var x: int
	if box.global_position.x < 200:
		x = -80 
	else:
		x = 40
	player.destination = box.global_position - Vector2( x, 40 )



func _start_interval_timer( ) -> void:
	interval_timer.stop()
	interval_timer.wait_time = level_tasks.get_interval_time()
	interval_timer.start()

func _on_timer_expiry() -> void:
	if level_tasks.are_there_more_tasks():
		add_new_task( level_tasks.next_task() )

func add_new_task ( task: Task ) -> void:
	new_word_added.emit( task_ui_manager.add_new_box ( task ) )
	_start_interval_timer()
