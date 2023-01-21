extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var reset_game = false

func _integrate_forces(state):
	if reset_game == true:
		print("in reset")
		state.transform = Transform2D(0.0, Vector2(144, 250))
		self.reset_game = false
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
