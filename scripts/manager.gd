extends Node2D

@onready var boxes: Node2D = $"Boxes Parent"

var word_typed_so_far := ""
var selected_index := -1
var _list_of_words : Array [ Box ] = [] 

func _ready () -> void:
	for box in boxes.get_children( false ):
		if box is Box:
			_list_of_words.append( box )

func _char_entered ( character : String ) -> void:
	if selected_index >= 0:
		# Something is typed so far
		var word := _list_of_words[selected_index]
		var typed_length := word_typed_so_far.length()
		var index = word.box_word.find( character, typed_length - 1 )
		
		if typed_length == index:
			word_typed_so_far += character
	else:
		var index := selected_index
		for word in _list_of_words:
			index += 1
			if ( word.box_word.begins_with ( character ) ):
				word_typed_so_far = character
				selected_index = index
				return
		print ( "Character Not Found in Words" + character )

func _input ( event: InputEvent ) -> void:
	if event is InputEventKey and event.is_pressed():
		if ( event.keycode >= KEY_A and event.keycode <= KEY_Z ):
			_char_entered( String.chr ( event.keycode ) )
		else:
			print ( "Event Key Pressed = " + str ( event.keycode ) )
