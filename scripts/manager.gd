extends Node2D

@export var display: Control

const _invalid_index := -1
const _invalid_selection := ""

var word_typed_so_far := _invalid_selection
var selected_index := _invalid_index
var _list_of_words : Array [ TypingBox ] = []
var _caps_lock_enabled = false

signal on_word_selected ( word: TypingBox )
signal on_word_typed ( word: TypingBox )

func set_initial_list_of_words ( words: Array [ TypingBox ] ) -> void:
	_list_of_words = words

func append_new_word ( word: TypingBox ) -> void:
	_list_of_words.append( word )

func _set_selection ( index: int = _invalid_index, character : String = _invalid_selection ) -> void:
	selected_index = index
	word_typed_so_far = character

func _on_selected_index ( character : String ) -> void:
	# Something is typed so far
	var box := _list_of_words[ selected_index ]
	var word := box.box_text
	var typed_length := word_typed_so_far.length()
	
	if character == word[ typed_length ]:
		word_typed_so_far += character
		box.selected_count ( word_typed_so_far.length() )
		if word_typed_so_far == word:
			_on_word_completed( box )

func _on_new_word ( character : String ) -> void:
	var index := selected_index
	for word in _list_of_words:
		index += 1
		if ( word.box_text.begins_with ( character ) ):
			_set_selection( index, character )
			word.selected_count ( 1 )
			on_word_selected.emit( word )
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

func _on_word_completed ( box: TypingBox ) -> void:
	_list_of_words.erase( box )
	_set_selection()
	on_word_typed.emit( box )
