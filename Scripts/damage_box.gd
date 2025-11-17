extends Area2D

@export var enemy : Enemy


func _process(delta: float) -> void:
	var overlapping_areas = get_overlapping_areas()
	for body in overlapping_areas:
		if body.is_in_group("enemies") && Input.is_action_just_pressed("attack"):
			handle_enemy_death(body)

func handle_enemy_death(enemy):
		enemy.owner.die()
