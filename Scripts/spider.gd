extends CharacterBody2D

@export var patrol_points: Array[Vector2] = []
@export var speed: float = 40.0
@export var detection_radius: float = 100.0

var patrol_index := 0
var player: Node2D = null
var is_chasing := false
var is_dead := false

func _ready():
	# Find the player in the scene tree
	player = get_tree().get_root().get_node("Main/Player")  # Adjust 

func _physics_process(_delta):
	if is_dead:
		return

	# Check if player is within detection range
	if player and global_position.distance_to(player.global_position) < detection_radius:
		is_chasing = true
	else:
		is_chasing = false

	# Movement logic
	if is_chasing:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		if patrol_points.size() > 0:
			var target = patrol_points[patrol_index]
			var direction = (target - global_position).normalized()
			velocity = direction * speed

			if global_position.distance_to(target) < 5:
				patrol_index = (patrol_index + 1) % patrol_points.size()
		else:
			velocity = Vector2.ZERO

	# Flip sprite based on movement direction
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

	# Play walk animation if moving
	if velocity.length() > 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.stop()

	move_and_slide()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if body.name == "PlayerAttack":  # Adjust  
		die()

func _on_damage_box_body_entered(body: Node2D) -> void:
	if is_dead:
		return

	if body.name == "Player":  # Adjust 
		if body.has_method("take_damage"):
			body.take_damage(1)  # Adjust 

func die():
	is_dead = true
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Death")
	$AnimatedSprite2D.animation_finished.connect(_on_death_animation_finished)

func _on_death_animation_finished():
	if $AnimatedSprite2D.animation == "Death":
		queue_free()
