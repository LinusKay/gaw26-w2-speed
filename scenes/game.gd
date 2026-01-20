extends Node

signal challenge_loaded
signal challenge_unloaded

var load_more: bool = true

var lives: int = 4

var challenge_index: int = 1
@onready var challenges: Array[PackedScene] = [
	preload("res://scenes/challenges/challenge_test.tscn"),
	preload("res://scenes/challenges/challenge_inputpin.tscn"),
	preload("res://scenes/challenges/challenge_hitwithcar.tscn"),
	preload("res://scenes/challenges/challenge_dontclicktowin.tscn"),
	preload("res://scenes/challenges/challenge_enterdisco.tscn"),
]
var challenges_temp: Array[PackedScene] = challenges.duplicate()

var level_number: int = 0


@onready var result_timer: Timer = $ResultTimer
@onready var label_win: RichTextLabel = $Control/LabelWin
@onready var label_lose: RichTextLabel = $Control/LabelLose
@onready var label_level: Label = $Control/LabelLevel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sfx_announcer: AudioStreamPlayer = $SFXAnnouncer
@onready var texture_rect_background: TextureRect = $Control/TextureRectBackground
@onready var label_lives: Label = $Control/LabelLives

@onready var sfx_announcer_lines_failure: Array[AudioStream] = [
	preload("res://audio/sfx/warioware_gold_jimmyt/90.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/91.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/92.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/93.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/95.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/96.wav"),
]
@onready var sfx_announcer_lines_success: Array[AudioStream] = [
	preload("res://audio/sfx/warioware_gold_jimmyt/98.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/99.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/101.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/102.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/103.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/104.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/105.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/106.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/107.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/109.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/110.wav"),
	preload("res://audio/sfx/warioware_gold_jimmyt/113.wav"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_challenge(_select_random_challenge())
	label_level.text = "Level " + str(level_number)

func _input(_event: InputEvent) -> void:
	if not GameSettings.ACCEPTING_INPUT:
		get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		var current_challenges: Array[Node] = get_tree().get_nodes_in_group("challenge")
		if current_challenges.size() > 0:
			unload_challenge()
		else:
			load_challenge(_select_random_challenge())


func load_challenge(new_challenge: Node) -> void:
	new_challenge.challenge_complete.connect(_show_results)
	add_child(new_challenge)
	
	challenge_loaded.emit(new_challenge)
	GameSettings.GAME_SPEED += 0.01
	level_number += 1
	label_level.text = "Level " + str(level_number)
	audio_stream_player.pitch_scale = 1.0 * (GameSettings.GAME_SPEED)
	texture_rect_background.material.set("shader_parameter/sprite_scroll_speed", 0.005 + (level_number * 0.025))
	label_lives.text = "Lives: " + str(lives)
	


func unload_challenge() -> void:
	var current_challenge: Node = get_tree().get_first_node_in_group("challenge")
	
	current_challenge.challenge_complete.disconnect(_show_results)
	current_challenge.queue_free()
	
	challenge_unloaded.emit(current_challenge)


func _on_challenge_loaded(new_challenge: Node) -> void:
	print("Loaded challenge: ", new_challenge.challenge_name)


func _on_challenge_unloaded(unloaded_challenge) -> void:
	print("Unloaded challenge: ", unloaded_challenge.challenge_name)
	if load_more: 
		load_challenge(_select_random_challenge())


func _select_random_challenge() -> Node:
	if challenges_temp.size() > 1:
		challenges_temp.remove_at(0)
	else:
		challenges_temp = challenges.duplicate()
		challenges_temp.shuffle()
	var new_challenge: Node = challenges_temp[0].instantiate()
	return new_challenge


func _on_result_timer_timeout() -> void:
	label_win.hide()
	label_lose.hide()
	unload_challenge()
	GameSettings.ACCEPTING_INPUT = true


func _show_results(success: bool) -> void:
	if success:
		label_win.show()
		sfx_announcer.stream = sfx_announcer_lines_success.pick_random()
		sfx_announcer.play()
	else:
		label_lose.show()
		sfx_announcer.stream = sfx_announcer_lines_failure.pick_random()
		sfx_announcer.play()
		lives -= 1
		if lives <= 0: 
			get_tree().reload_current_scene()
			return
	result_timer.start()
	GameSettings.ACCEPTING_INPUT = false


func _on_button_quit_pressed() -> void:
	get_tree().quit()
