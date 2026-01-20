extends Challenge

#@onready var timer: Timer = $Timer
@onready var label_prompt: Label = $Control/LabelPrompt
#@onready var label_timer: Label = $Control/LabelTimer
@onready var texture_rect: TextureRect = $Control/TextureRect
@onready var texture_bug_splat: Texture2D = preload("res://scenes/challenges/challenge_dontclicktowin/buge_splat.png")
var clicked: bool = false


#func _process(_delta: float) -> void:
	#label_timer.text = str(int(ceil(timer.time_left)))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and event is InputEventMouseButton:
		_challenge_complete(false)
		texture_rect.texture = texture_bug_splat


func _on_challenge_timer_timeout() -> void:
	if not clicked:
		_challenge_complete(true)
	else:
		_challenge_complete(false)
