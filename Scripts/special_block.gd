extends StaticBody2D

@onready var special_block: StaticBody2D = $"."

func _process(delta: float) -> void:
	if CollectionManager.has_key == true:
		special_block.queue_free()
		await special_block.tree_exited
		CollectionManager.has_key = false
