extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum GameState {START, PLAYING, GAME_OVER}

var state = GameState.START
var scores = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	state = GameState.START

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	var bird = get_node("Bird")
	var start_screen = $"Start game"
	
	if state == GameState.PLAYING and event.is_action_pressed("ui_select"):
		print("impulse")
		bird.apply_central_impulse(Vector2(0,-300))
	
	if state == GameState.START and event.is_action_pressed("ui_select"):
		print("starting...")
		start_screen.visible = false
		bird.visible = true
		bird.mode = RigidBody2D.MODE_RIGID
		state = GameState.PLAYING
		
	if state == GameState.GAME_OVER and event.is_action_pressed("ui_select"):
		var over = get_node("Game Over")
		print("after game over")
		over.visible = false
		bird.visible = true
		bird.reset_game = true
		state = GameState.PLAYING

func game_over():
	var bird = get_node("Bird")
	var over = get_node("Game Over")
	bird.visible = false
	over.visible = true
	scores = 0
	state = GameState.GAME_OVER

func bird_is_dead(body):
	game_over()


func _on_Pipes_pipe_hit():
	game_over()
	pass # Replace with function body.


func _on_Pipes_score():
	scores += 1
