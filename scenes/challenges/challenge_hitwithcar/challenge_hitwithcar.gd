extends Challenge

@onready var character_body_3d: CharacterBody3D = $Node3D/CharacterBody3D
var target_hit: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_failure_body_entered(body: Node3D) -> void:
	if target_hit:
		_challenge_complete(true)
	else:
		_challenge_complete(false)
	

func _on_area_3d_success_body_entered(body: Node3D) -> void:
	target_hit = true
