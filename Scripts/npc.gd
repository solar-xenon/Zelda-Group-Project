extends Node2D

@export var required_kills: int = 5
@export var reward_scene: PackedScene

var player_ref: Node2D = null

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_ref = body
		_show_dialogue()

func _on_body_exited(body: Node2D) -> void:
	if body == player_ref:
		player_ref = null
		$Label.text = ""

func _show_dialogue():
	if player_ref == null:
		return

	var kills = CollectionManager.enemies_killed
	if kills < required_kills:
		$Label.text = "Kill " + str(required_kills) + " enemies! Progress: " + str(kills) + "/" + str(required_kills)
	else:
		if CollectionManager.key_count > 0:
			return
		else:
			$Label.text = "Quest complete! Thank you!"
			CollectionManager.key_count += 1
			_drop_reward()

func _drop_reward():
	if reward_scene:
		var reward = reward_scene.instantiate()
		reward.global_position = global_position + Vector2(32, 0)
		get_parent().add_child(reward)
		print("🎁 NPC dropped reward!")
