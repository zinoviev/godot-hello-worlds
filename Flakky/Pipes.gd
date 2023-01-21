extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal pipe_hit
signal score

onready var bottom = $"Bottom"
onready var top = $"Top"
onready var score = $"Score"

var velocity = -2.0

# Called when the node enters the scene tree for the first time.
func _ready():
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
