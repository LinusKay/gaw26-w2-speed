class_name Challenge extends Node

signal challenge_complete(success: bool)

@export var challenge_name: String = "Challenge ??"
@onready var label_challenge_name: Label = $Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_challenge_name.text = challenge_name


func _challenge_complete(success: bool) -> void:
	if success: 
		print("challenge success: ", challenge_name)
		challenge_complete.emit(true)
	else: 
		print("challenge faillure: ", challenge_name)
		challenge_complete.emit(false)
