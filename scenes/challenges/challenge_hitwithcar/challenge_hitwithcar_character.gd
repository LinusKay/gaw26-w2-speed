extends CharacterBody3D


var speed = 5.0 * GameSettings.GAME_SPEED

func _ready() -> void:
	velocity.z = -speed


func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_axis("ui_left", "ui_right")
	var dir := Vector3.RIGHT * input_dir
	
	if input_dir:
		velocity.x = dir.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
