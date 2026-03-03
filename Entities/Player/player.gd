extends CharacterBody2D
class_name Player


var amount := 1
signal health_changed(amount)

@export var speed := 100.0
@export var jump_velocity := -600.0
@export var gravity := 900.0

@export var max_jumps := 2
var current_jumps := max_jumps

var facing_direction := 1  # 1 = right, -1 = left

@onready var Attack = $Attack_Projectile                                                                                              
var is_attacking:bool = false
var attack_cooldown: bool = false
#matter 
@onready var attack_hitbox: Area2D = $Attack_Projectile
@onready var attack_hitbox_shape: CollisionShape2D = $Attack_Projectile/Attack_Collider

@onready var state_machine = $StateMachine
@onready var player_attack_anim = $Attack_Projectile/PlayerAttackAnimation

func _ready():
	add_to_group("player")
	$Attack_Projectile/Attack_Collider.disabled = false
	player_attack_anim.visible = false
	disable_attack_hitbox()
	
func _physics_process(delta):
	state_machine._physics_process(delta)
	move_and_slide()
	
func update_facing(input):
	if is_attacking: 
		return 
		
	if input != 0:     
		facing_direction = 1 if input > 0 else -1
		$AnimatedSprite2D.flip_h = (facing_direction == 1)
		#$Attack_Projectile.scale.x = -1 * facing_direction
	
func facing_direction_fn(input):
	if input > 0:
		return true
	elif input < 0:
		return false
	else:
		return self.facing_direction
		
func enable_attack_hitbox():
	attack_hitbox_shape.disabled = false

func disable_attack_hitbox():
	attack_hitbox_shape.disabled = true

func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		Global.hp_fragments -= 1
		if Global.hp_fragments == 0:
			return
		print("player got hit")
		health_changed.emit(amount)
		
func perform_attack():
	if attack_cooldown: return
	is_attacking = true
	attack_cooldown = true
	$Attack_Projectile.scale.x = -facing_direction
	
	player_attack_anim.visible = true
	player_attack_anim.play("default_slash")
	$AnimatedSprite2D.play("attack") 
	velocity.x += 50 * facing_direction
	
	await get_tree().create_timer(0.06).timeout
	enable_attack_hitbox()
	
	await get_tree().create_timer(0.08).timeout
	disable_attack_hitbox()
	
	await get_tree().create_timer(0.1).timeout 
	is_attacking = false
	player_attack_anim.visible = false
	
	await get_tree().create_timer(0.4).timeout
	attack_cooldown = false
