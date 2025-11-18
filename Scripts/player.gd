extends CharacterBody2D

class_name Player

const SPEED = 100.0

var input_vector = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

@export var enemy = Enemy


func _physics_process(delta: float) -> void:
	if playback != null:
		var state = playback.get_current_node()
		match state:
			"MoveState": move_state(delta)
			"AttackState": pass

func move_state(delta: float) -> void:
	if playback != null:
		input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if input_vector != Vector2.ZERO:
			animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position", input_vector)

		if Input.is_action_just_pressed("attack"):
			playback.travel("AttackState")

		velocity = input_vector * SPEED
		move_and_slide()
		
