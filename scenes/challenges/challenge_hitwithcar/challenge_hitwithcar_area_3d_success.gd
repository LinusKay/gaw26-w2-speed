extends Area3D

@export var spawn_x_limit: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randf_range(-spawn_x_limit, spawn_x_limit)
