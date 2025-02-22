extends Node2D

@onready var player: Player = $Player
@onready var interval_timer: Timer = $"Interval Timer"

@export var level_tasks : LevelData
@export var task_ui_manager: Control
@export var center_right: Control
@export var center_left: Control
@export var bottom: Control

signal new_word_added ( word: TypingBox )

func _ready () -> void:
	_on_timer_expiry()
	player.destination = get_viewport_rect().size / 2

func on_task_completed( word: TypingBox ) -> void:
	task_ui_manager.word_typed( word )
	if level_tasks.are_there_more_tasks():
		add_new_task( level_tasks.next_task() )

func on_word_selected( box : TypingBox ) -> void:
	_calculate_sprite_position( box )

func _calculate_sprite_position ( box : TypingBox ) -> void:
	var left_distance = box.global_position.distance_to( center_left.global_position )
	var right_distance = box.global_position.distance_to( center_right.global_position )
	var bottom_distance = box.global_position.distance_to( bottom.global_position )
	var location : Control	
	print ( "Left = " + str ( left_distance ) + ", Right = " + str ( right_distance ) + " & Bottom = " + str ( bottom_distance ) )
	
	if box.global_position.y > get_viewport_rect().size.y / 2:
		location = bottom
	if left_distance < right_distance && left_distance < bottom_distance:
		location = center_left
	else:
		location = center_right
	
	player.destination = location.global_position


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
