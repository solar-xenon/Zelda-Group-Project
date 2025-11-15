extends Area2D

func _ready():
	monitoring = true  # Keep this to ensure the Area2D is active

func _on_body_entered(body: Node2D) -> void:
	print("✅ TestBox collided with:", body.name)

func _on_area_entered(area: Area2D) -> void:
	print("✅ TestBox overlapped with:", area.name)
