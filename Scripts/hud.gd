extends CanvasLayer


func _ready():
	var scene_path = get_tree().current_scene.scene_file_path

	if "cutscene" in scene_path:
		visible = false
	else:
		visible = true


func _process(delta: float) -> void:
	update_kills()
	update_key()
	update_medal()

func update_kills():
	$VBoxContainer/KillCount.text = "Enemies Killed: " + str(CollectionManager.enemies_killed)

func update_key():
	if CollectionManager.has_key:
		$VBoxContainer/HasKey.text = "Key: Yes"
	else:
		$VBoxContainer/HasKey.text = "Key: No"

func update_medal():
	$VBoxContainer/MedalCount.text = "Medals Collected: " + str(CollectionManager.medal_amount)
