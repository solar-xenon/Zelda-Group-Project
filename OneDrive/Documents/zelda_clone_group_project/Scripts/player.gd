extends CharacterBody2D

@export var speed: float = 120.0
@export var attack_duration: float = 0.5

# Exported NodePaths for HUD labels (set these in each scene)
@export var kill_label_path: NodePath       # drag HUD/KillLabel here
@export var inventory_label_path: NodePath  # drag HUD/InventoryLabel here

var enemies_killed: int = 0
var is_attacking: bool = false
var attack_timer: float = 0.0

var kill_label: Label
var inventory_label: Label
var inventory: Array = []

var anim_tree: AnimationTree
var playback: AnimationNodeStateMachinePlayback

func _ready():
	anim_tree = $AnimationTree
	playback = anim_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
	anim_tree.active = true

	# ✅ Connect HUD labels per scene
	if kill_label_path != NodePath():
		kill_label = get_node(kill_label_path)
		kill_label.text = "Enemies killed: 0"
		print("✅ KillLabel connected:", kill_label)
	else:
		print("❌ KillLabel path not assigned in this scene")

	if inventory_label_path != NodePath():
		inventory_label = get_node(inventory_label_path)
		inventory_label.text = "Inventory: (empty)"
		print("✅ InventoryLabel connected:", inventory_label)
	else:
		print("❌ InventoryLabel path not assigned in this scene")

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0.0:
			is_attacking = false
			playback.travel("MoveState")
	else:
		if input_vector != Vector2.ZERO:
			velocity = input_vector * speed
			playback.travel("MoveState")
		else:
			velocity = Vector2.ZERO
			playback.travel("MoveState")

		if Input.is_action_just_pressed("attack"):
			_start_attack()

	move_and_slide()

func _start_attack():
	is_attacking = true
	attack_timer = attack_duration
	playback.travel("AttackState")
	print("Attack input triggered")

# Called by Enemy when it dies
func register_enemy_kill():
	enemies_killed += 1
	print("💥 Enemy killed! Total:", enemies_killed)

	if kill_label:
		kill_label.text = "Enemies killed: " + str(enemies_killed)
		print("HUD updated:", kill_label.text)
	else:
		print("❌ KillLabel not connected in this scene")

# Item pickup logic
func obtain_item(item_name: String):
	inventory.append(item_name)
	print("🎒 Obtained item:", item_name)

	if inventory_label:
		inventory_label.text = "Inventory: " + ", ".join(inventory)
		print("HUD updated:", inventory_label.text)
	else:
		print("❌ InventoryLabel not connected in this scene")
