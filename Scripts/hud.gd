extends CanvasLayer


func _ready():
	var scene_path = get_tree().current_scene.scene_file_path

	if "cutscene" in scene_path:
		visible = false
	else:
		visible = true


func _process(delta: float) -> void:
	update_kills()
	update_medal()

func update_kills():
	$VBoxContainer/KillCount.text = "Enemies Killed: " + str(CollectionManager.enemies_killed)

func update_medal():
	$VBoxContainer/MedalCount.text = "Medals Collected: " + str(CollectionManager.medal_amount)
