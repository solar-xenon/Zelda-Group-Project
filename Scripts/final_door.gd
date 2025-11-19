extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		trigger_endgame()
		

func trigger_endgame():
	CollectionManager.check_endgame()
