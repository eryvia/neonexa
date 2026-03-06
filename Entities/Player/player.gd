extends CharacterBody2D
class_name Player

signal health_changed(amount)

#Ui elements
var is_paused = false

#Player Configs
@export var fall_gravity := 1500.0
@export var fall_velocity := 500
@export var walk_velocity := 100.0

@export var dash_velocity := 200.0
@export var dash_duration := 0.3
var can_dash := true

var wall_velocity := 80.0
var wall_gravity := 400.0

@export var jump_velocity := -500.0
@export var max_jumps := 2
var current_jumps := max_jumps
var amount := 1
@onready var _can_travel = true

#Cds
var is_dead = false
var input_direction := 1 # 1 = right, -1 = left

@onready var Attack = $Attack_Projectile                                                                                              
var is_attacking:bool = false
var attack_cooldown: bool = false

#matter 
@onready var attack_hitbox: Area2D = $Attack_Projectile
@onready var attack_hitbox_shape: CollisionShape2D = $Attack_Projectile/Attack_Collider
@onready var state_machine = $StateMachine
@onready var player_attack_anim = $Attack_Projectile/PlayerAttackAnimation
@onready var player_animation = $AnimatedSprite2D
@onready var gm = $CanvasLayer/GameplayUI
@onready var dash_anim = $DashImpactAnim


func _ready():
	Global.player = self
	$Attack_Projectile/Attack_Collider.disabled = false
	player_attack_anim.visible = false
	disable_attack_hitbox()
	
func _physics_process(delta):
	state_machine._physics_process(delta)
	move_and_slide()
	
func _input(event):
	if is_dead: return
	if event.is_action_pressed("ui_cancel") and not is_paused:
		is_paused = true
		PauseMenu.open($CanvasLayer/GameplayUI, self)
		
func start_dash_cooldown() -> void:
	can_dash = false
	await get_tree().create_timer(0.6).timeout
	can_dash = true
		
func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		Global.hp_fragments -= 1
		if Global.hp_fragments == 0:
			return
		print("player got hit")
		health_changed.emit(amount)
	
#Attack Hitboxes
func enable_attack_hitbox():
	attack_hitbox_shape.disabled = false

func disable_attack_hitbox():
	attack_hitbox_shape.disabled = true

func perform_attack():
	if attack_cooldown: return
	is_attacking = true
	attack_cooldown = true
	
	if input_direction > 0:
		$Attack_Projectile.scale.x = -1
	else: 
		$Attack_Projectile.scale.x = 1
		
	#$Attack_Projectile.scale.x = input_direction
	
	player_attack_anim.visible = true
	player_attack_anim.play("default_slash")
	$AnimatedSprite2D.play("attack") 
	velocity.x += 50 * input_direction
	
	#anticipitaion ->. kinda just left it.
	await get_tree().create_timer(0.06).timeout
	enable_attack_hitbox()
	
	$AttackSoundEffect.play()
	
	await get_tree().create_timer(0.04).timeout
	disable_attack_hitbox()
	
	await get_tree().create_timer(0.1).timeout 
	
	is_attacking = false
	player_attack_anim.visible = false
	
	await get_tree().create_timer(0.4).timeout
	
	attack_cooldown = false
	
	
func update_facing(input):
	if is_attacking: 
		return 
		
	if input != 0:     
		input_direction = 1 if input > 0 else -1
		#$Attack_Projectile.scale.x = -1 * facing_direction
	 
func handle_movement() -> void:
	var input_direction := signf(Input.get_axis("move_left", "move_right"))
	if input_direction:
		player_animation.flip_h = input_direction > 0
	velocity.x = input_direction * walk_velocity
	
func die() -> void:
	if is_dead: return
	is_dead = true
	DeadScreen.open(gm, self)
	Engine.time_scale = 0.0
	
