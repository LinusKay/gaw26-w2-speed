extends Challenge

@onready var area_click_failure: Area2D = $AreaClickFailure
@onready var area_click_success: Area2D = $AreaClickSuccess

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_click_success_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			_challenge_complete(true)


func _on_area_click_failure_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			_challenge_complete(false)


func _challenge_complete(success: bool) -> void:
	print("challenge complete init")
	super(success)
