extends Area2D

func _physics_process(_delta):
	monitoring = true

	var player = get_parent()
	var anim_tree = player.get_node_or_null("AnimationTree")
	if anim_tree == null:
		return

	var playback = anim_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
	if playback == null:
		return

	if playback.get_current_node() == "AttackState":
		for area in get_overlapping_areas():
			if area.name == "HurtBox":
				# Find the parent enemy node (could be Skelly, Spider, etc.)
				var enemy = area.get_parent()
				if enemy and enemy.has_method("die"):
					print("✅ " + enemy.name + " killed during AttackState")
					enemy.die()
