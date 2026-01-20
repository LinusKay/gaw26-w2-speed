extends Challenge

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var area_2d: Area2D = $Area2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	_challenge_complete(true)
