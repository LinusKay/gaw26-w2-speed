class_name Challenge extends Node

signal challenge_success
signal challenge_failure

@export var challenge_name: String = "Challenge ??"
@onready var label_challenge_name: Label = $Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_challenge_name.text = challenge_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _challenge_complete(success: bool) -> void:
	if success: 
		print("challenge success: ", challenge_name)
		challenge_success.emit()
	else: 
		print("challenge faillure", challenge_name)
		challenge_failure.emit()
