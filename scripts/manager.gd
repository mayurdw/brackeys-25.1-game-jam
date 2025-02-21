extends Node2D

var box_node := preload("res://scenes/lettered_box.tscn")

@onready var display: Control = $HUD/TypedLetter
@onready var task_ui_manager: Control = $"HUD/Task UI Manager"
@onready var interval_timer: Timer = $"Interval Timer"
@onready var center_right: Control = $"HUD/Center Right Sprite Placement"
@onready var center_left: Control = $"HUD/Center Left Sprite Placement"
@onready var bottom: Control = $"HUD/Bottom Sprite Placement"
@onready var player: Player = $Player

@export var level_tasks : LevelData

const _invalid_index := -1
const _invalid_selection := ""

var word_typed_so_far := _invalid_selection
var selected_index := _invalid_index
var _list_of_words : Array [ Box ] = []
var _caps_lock_enabled = false

func _ready () -> void:
	_list_of_words = task_ui_manager.get_list_of_boxes()
	_on_timer_expiry()
	player.destination = get_viewport_rect().size / 2

func _set_selection ( index: int = _invalid_index, character : String = _invalid_selection ) -> void:
	selected_index = index
	word_typed_so_far = character

func _on_selected_index ( character : String ) -> void:
	# Something is typed so far
	var box := _list_of_words[ selected_index ]
	var word := box.task.task_name
	var typed_length := word_typed_so_far.length()
	
	if character == word[ typed_length ]:
		word_typed_so_far += character
		box.selected_count ( word_typed_so_far.length() )
		if word_typed_so_far == word:
			_on_task_completed( box )

func _calculate_sprite_position ( box : Box ) -> Control:
	var left_distance = box.global_position.distance_to( center_left.global_position )
	var right_distance = box.global_position.distance_to( center_right.global_position )
	var bottom_distance = box.global_position.distance_to( bottom.global_position )
	
	print ( "Left = " + str ( left_distance ) + ", Right = " + str ( right_distance ) + " & Bottom = " + str ( bottom_distance ) )
	
	if box.global_position.y > get_viewport_rect().size.y / 2:
		return bottom
	if left_distance < right_distance && left_distance < bottom_distance:
		return center_left
	else:
		return center_right

func _on_new_word ( character : String ) -> void:
	var index := selected_index
	for word in _list_of_words:
		index += 1
		if ( word.task.task_name.begins_with ( character ) ):
			_set_selection( index, character )
			word.selected_count ( 1 )
			player.destination = _calculate_sprite_position( word ).global_position
			return

	print ( "Character Not Found in Words = " + character )

func _on_back_space () -> void:
	display.letter_typed ( "BSP" )
	if selected_index >= 0:
		var typed_length = word_typed_so_far.length()

		if typed_length == 1:
			_list_of_words[selected_index].reset_count()
			_set_selection()
		else:
			word_typed_so_far[ typed_length - 1 ] = ""
			_list_of_words[selected_index].selected_count( typed_length - 1 )

func _char_entered ( character : String ) -> void:
	if selected_index >= 0:
		_on_selected_index( character )
	else:
		_on_new_word( character )

func _input ( event: InputEvent ) -> void:
	if event is InputEventKey and event.is_pressed():
		if KEY_CAPSLOCK == event.keycode:
			_caps_lock_enabled = not _caps_lock_enabled
		elif event.keycode >= KEY_A and event.keycode <= KEY_Z:
			var character = String.chr ( event.keycode )
			if not event.shift_pressed and not _caps_lock_enabled:
				character = character.to_lower()
			display.letter_typed ( character )
			_char_entered( character )
		elif KEY_ESCAPE == event.keycode:
			display.letter_typed ( "ESC" )
			_list_of_words[selected_index].reset_count()
			_set_selection()
		elif KEY_BACKSPACE == event.keycode:
			_on_back_space()
		elif KEY_SHIFT == event.keycode:
			pass
		else:
			print ( "Event Key Pressed = " + str ( event.keycode ) )

func _on_task_completed ( box: Box ) -> void:
	_list_of_words.erase( box )
	box.word_typed()
	_set_selection()
	if level_tasks.are_there_more_tasks():
		add_new_task( level_tasks.next_task() )

func add_new_task ( task: Task ) -> void:
	var box_instance = box_node.instantiate()
	
	box_instance.task = task
	task_ui_manager.add_new_box ( box_instance )
	_list_of_words.append( box_instance )
	_start_interval_timer()

func add_tasks ( tasks: Array [ Task ] ) -> void:
	for task in tasks:
		add_new_task ( task )

func _start_interval_timer( ) -> void:
	interval_timer.stop()
	interval_timer.wait_time = level_tasks.get_interval_time()
	interval_timer.start()

func _on_timer_expiry() -> void:
	if level_tasks.are_there_more_tasks():
		add_new_task( level_tasks.next_task() )
