extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		CollectionManager.has_key = true
		queue_free()
	else:
		return
