extends Challenge

@onready var area_click_success: Area2D = $Control/AreaClickSuccess
@onready var area_click_failure: Area2D = $Control/AreaClickFailure



func _on_area_click_success_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			_challenge_complete(true)


func _on_area_click_failure_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			_challenge_complete(false)


func _challenge_complete(success: bool) -> void:
	super(success)
