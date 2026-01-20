extends CharacterBody3D

@export var spawn_x_limit: float = 3.0
var speed = 5.0 + (GameSettings.GAME_SPEED * 3)

func _ready() -> void:
	velocity.z = -speed
	position.x = randf_range(-spawn_x_limit, spawn_x_limit)


func _physics_process(_delta: float) -> void:
	if GameSettings.ACCEPTING_INPUT:
		var input_dir := Input.get_axis("ui_left", "ui_right")
		var dir := Vector3.RIGHT * input_dir
		
		if input_dir:
			velocity.x = dir.x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
