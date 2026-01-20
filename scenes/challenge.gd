class_name Challenge extends Node

signal challenge_complete(success: bool)

@export var challenge_name: String = "Challenge ??"
@onready var label_challenge_name: Label = $Control/Label
@onready var challenge_timer: Timer = $ChallengeTimer
@onready var label_timer: Label = $Control/LabelTimer

@export var timed: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_challenge_name.text = challenge_name
	if timed:
		challenge_timer.start()
		label_timer.show()
	else:
		challenge_timer.stop()
		label_timer.hide()


func _process(_delta: float) -> void:
	if timed:
		label_timer.text = str(int(ceil(challenge_timer.time_left)))


func _challenge_complete(success: bool) -> void:
	challenge_timer.paused = true
	if success: 
		print("challenge success: ", challenge_name)
		challenge_complete.emit(true)
	else: 
		print("challenge faillure: ", challenge_name)
		challenge_complete.emit(false)


func _on_challenge_timer_timeout() -> void:
	_challenge_complete(false)
