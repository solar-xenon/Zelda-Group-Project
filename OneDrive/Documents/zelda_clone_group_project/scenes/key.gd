extends Node2D

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("🔑 Player picked up the key!")
		body.obtain_item("Key")   # call Player method
		queue_free()              # remove key from world
