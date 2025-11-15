extends Area2D

func _ready():
	monitoring = true
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	print("🟡 HitSender overlapped:", area.name)
	if area.name == "HitReceiver":
		var target = area.find_parent("TestEnemy")
		if target and target.has_method("vanish"):
			print("✅ Calling vanish() on TestEnemy")
			target.vanish()
		else:
			print("❌ Could not find TestEnemy or vanish() method")
