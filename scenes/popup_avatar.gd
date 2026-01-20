extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_talk: RichTextLabel = $Panel/MarginContainer/LabelTalk

var talk_lines: Array[String] = [
	"you are going to lose",
	"you should visit [url=https://google.com/]website[/url]",
]

func _ready() -> void:
	popup()
	talk()


func popup() -> void:
	animation_player.play("slide_up")

func talk() -> void:
	label_talk.text = talk_lines.pick_random()


func _on_area_2d_close_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		queue_free()


func _on_label_talk_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
