extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal pipe_hit
signal score

onready var bottom = $"Bottom"
onready var top = $"Top"
onready var score = $"Score"

export var velocity = -3.0
export var offset = 0

func set_offset(offset):
	print("set offset")
	self.offset = offset

func _ready():
	print("ready")
	bottom.position += Vector2(0, offset)
	top.position += Vector2(0, offset)
	score.position += Vector2(0, offset)
	pass # Replace with function body.
	

func _process(delta):
	bottom.position += Vector2(velocity,0)
	top.position += Vector2(velocity, 0)
	score.position += Vector2(velocity, 0)

func _on_Bottom_body_entered(body):
	emit_signal("pipe_hit")

func _on_Top_body_entered(body):
	emit_signal("pipe_hit")


func _on_Score_body_exited(body):
	emit_signal("score")


func _on_VisibilityNotifier2D_screen_exited():
	print("destroy")
	queue_free()
