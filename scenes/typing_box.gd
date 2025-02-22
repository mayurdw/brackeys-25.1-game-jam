extends PanelContainer

@onready var label: RichTextLabel = $MarginContainer/CenterContainer/Label

@export var box_text : String = "" : set = _set_box_text

func _ready() -> void:
	box_text = ""

func _set_box_text ( text : String ) -> void:
	box_text = text
	label.text = box_text

func selected_count ( length : int, highlight_color : Color ) -> void:
	label.text = ""
	label.push_color ( highlight_color )
	label.append_text ( box_text.substr( 0, length ) )
	label.pop()
	label.append_text ( box_text.substr( length ) )

func reset_count () -> void:
	label.text = box_text
