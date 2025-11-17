extends CharacterBody2D

var is_dead = false

func _ready():
	print("🟢 TestEnemy ready")

func vanish():
	if is_dead:
		return
	is_dead = true
	print("☠️ TestEnemy vanished")
	queue_free()
