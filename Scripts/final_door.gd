extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if CollectionManager.medal_amount == 3:
		print("pass")
