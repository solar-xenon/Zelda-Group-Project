extends Area2D

@export var next_level: String 
@export var transition: PackedScene 

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		_start_transition()
		
		
func _start_transition():
	var fade = transition.instantiate()
	get_tree().root.add_child(fade)
	var anim = fade.get_node("AnimationPlayer")
	await anim.animation_finished
	get_tree().change_scene_to_file(next_level)
