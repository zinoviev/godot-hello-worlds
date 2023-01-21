extends Node

var Pipes = load("res://Pipes.tscn")

enum GameState {START, PLAYING, GAME_OVER}

onready var generator = $"Pipe generator"

var state = GameState.START
var scores = 0
var pipes_store = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	state = GameState.START
	randomize()

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
		start_screen.visible = false
		$"Scores label".visible = true
		bird.visible = true
		bird.mode = RigidBody2D.MODE_RIGID
		state = GameState.PLAYING
		generator.start()
		
	if state == GameState.GAME_OVER and event.is_action_pressed("ui_select"):
		var over = get_node("Game Over")
		print("after game over")
		over.visible = false
		bird.visible = true
		bird.reset_game = true
		state = GameState.PLAYING
		generator.start()
		
func game_over():
	var bird = get_node("Bird")
	var over = get_node("Game Over")
	bird.visible = false
	over.visible = true
	scores = 0
	state = GameState.GAME_OVER
	
	for pipe in pipes_store:
		if pipe != null:
			remove_child(pipe)
	
	pipes_store = []
	generator.stop() 
	

func bird_is_dead(body):
	game_over()

func _on_Pipes_pipe_hit():
	game_over()

func _on_Pipes_score():
	scores += 1

func _on_Pipe_generator_timeout():
	var offset = rng.randi_range(-150,150)
	var pipes = Pipes.instance()
	pipes.set_offset(offset)
	pipes.connect("pipe_hit", self, "_on_Pipes_pipe_hit")
	pipes.connect("score", self, "_on_Pipes_score")
	
	
	add_child(pipes)
	pipes_store.append(pipes)
	
func _on_Update_label_timeout():
	$"Scores label".text = scores as String
