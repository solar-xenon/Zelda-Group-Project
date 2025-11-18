extends CanvasLayer

func _ready():
	update_kills()
	update_key()

func update_kills():
	$VBoxContainer/KillCount.text = "Enemies Killed: " + str(CollectionManager.enemies_killed)

func update_key():
	if CollectionManager.has_key:
		$VBoxContainer/HasKey.text = "Key: Yes"
	else:
		$VBoxContainer/HasKey.text = "Key: No"
