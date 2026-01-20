extends Challenge

@onready var animation_player: AnimationPlayer = $Control/SubViewport/Node3D/Area3DSuccess/Sprite3D/AnimationPlayer
@onready var character_body_3d: CharacterBody3D = $Control/SubViewport/Node3D/CharacterBody3D
var target_hit: bool = false


func _on_area_3d_failure_body_entered(_body: Node3D) -> void:
	if target_hit:
		_challenge_complete(true)
	else:
		_challenge_complete(false)
	

func _on_area_3d_success_body_entered(_body: Node3D) -> void:
	target_hit = true
	animation_player.play("hitwithcar")
