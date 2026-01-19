extends Node

signal challenge_loaded
signal challenge_unloaded

var load_more: bool = true

var challenge_index: int = 1
@onready var challenges: Array[PackedScene] = [
	preload("res://scenes/challenges/challenge_test.tscn"),
	preload("res://scenes/challenges/challenge_inputpin.tscn"),
	preload("res://scenes/challenges/challenge_inputpin.tscn"),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_challenge(_select_random_challenge())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		var current_challenges: Array[Node] = get_tree().get_nodes_in_group("challenge")
		if current_challenges.size() > 0:
			unload_challenge()
		else:
			load_challenge(_select_random_challenge())


func load_challenge(new_challenge: Node) -> void:
	add_child(new_challenge)
	
	new_challenge.challenge_success.connect(unload_challenge)
	new_challenge.challenge_failure.connect(unload_challenge)
	
	challenge_loaded.emit(new_challenge)


func unload_challenge() -> void:
	var current_challenge: Node = get_tree().get_first_node_in_group("challenge")
	
	current_challenge.challenge_success.disconnect(unload_challenge)
	current_challenge.challenge_failure.disconnect(unload_challenge)
	current_challenge.queue_free()
	
	challenge_unloaded.emit(current_challenge)


func _on_challenge_loaded(new_challenge: Node) -> void:
	print("Loaded challenge: ", new_challenge.challenge_name)


func _on_challenge_unloaded(unloaded_challenge) -> void:
	print("Unloaded challenge: ", unloaded_challenge.challenge_name)
	if load_more: 
		load_challenge(_select_random_challenge())


func _select_random_challenge() -> Node:
	var challenges_temp: Array[PackedScene] = challenges.duplicate()
	challenges_temp.pop_at(challenge_index)
	challenge_index = randi_range(0, challenges_temp.size() - 1)
	var new_challenge: Node = challenges_temp[challenge_index].instantiate()
	return new_challenge
