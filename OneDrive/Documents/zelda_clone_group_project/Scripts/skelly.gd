extends CharacterBody2D

@export var patrol_distance: float = 64.0
@export var speed: float = 40.0
@export var chase_speed: float = 80.0

var start_position: Vector2
var target_position: Vector2
var moving_to_target := true
var is_dead := false
var player_detected := false
var player_ref: Node2D = null

func _ready():
	start_position = global_position
	target_position = start_position + Vector2(patrol_distance, 0)
	# Connect once here, not inside die()
	$AnimatedSprite2D.animation_finished.connect(_on_death_animation_finished)

func _physics_process(_delta):
	if is_dead:
		return

	var direction := Vector2.ZERO

	if player_detected and player_ref != null:
		direction = (player_ref.global_position - global_position).normalized()
		velocity = direction * chase_speed
		$AnimatedSprite2D.play("Walk")
	else:
		direction = (target_position - global_position).normalized() if moving_to_target else (start_position - global_position).normalized()
		velocity = direction * speed
		$AnimatedSprite2D.play("Walk")

		if global_position.distance_to(target_position if moving_to_target else start_position) < 5:
			moving_to_target = !moving_to_target

	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):   # safer than name check
		player_detected = true
		player_ref = body
		print("Player detected — chasing!")

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		player_detected = false
		player_ref = null
		print("Player lost — resuming patrol")

func die():
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO
	print("☠️ " + name + " died")
	$AnimatedSprite2D.play("Death")

	# Notify player kill tracker
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.register_enemy_kill()

func _on_death_animation_finished():
	if $AnimatedSprite2D.animation == "Death":
		queue_free()
