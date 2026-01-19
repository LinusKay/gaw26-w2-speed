extends Challenge

@onready var input: LineEdit = $Control/Input
var input_last: String = ""
var input_goal: String = "1998"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_text_changed(new_text: String) -> void:
	var caret_column = input.caret_column
	if not new_text.is_empty():
		if new_text.is_valid_int():
			input.text = new_text
			input_last = new_text
		else:
			input.text = input_last
		
		input.caret_column = caret_column
			
		if new_text == input_goal:
			input.release_focus()
			_challenge_complete(true)
