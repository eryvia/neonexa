extends CharacterBody2D
class_name Player
signal health_changed(amount)

var is_paused = false
const PLATFORM_LAYER := 4

@export var walk_velocity := 150.0

@export var jump_velocity := -370.0
@export var max_jumps := 2
var current_jumps := max_jumps
@export var jump_steps_max := 5
@export var jump_release_multiplier := 0.0

@export var hang_time_steps_max := 6
@export var hang_time_gravity_start := 0.13

@export var coyote_time := 0.08
@export var jump_buffer_time := 0.2

@export var fall_gravity := 1500.0
@export var fall_velocity := 500
@export var terminal_velocity := 500.0

@export var dash_velocity := 200.0
@export var dash_duration := 0.3
var can_dash := true

var wall_velocity := 80.0
var wall_gravity := 400.0

var last_safe_position: Vector2

var amount := 1
var is_dead := false
var input_direction := 1
#var is_attacking := false
var attack_cooldown := false
var coyote_timer := 0.0
var jump_buffer_timer := 0.0
var start_hang_phase := false
@onready var _can_travel := true
var is_invincible = false

#@onready var Attack = $Attack_Projectile
@onready var attack_hitbox: Area2D = $Attack_Projectile
@onready var attack_hitbox_shape: CollisionShape2D = $Attack_Projectile/Attack_Collider
#@onready var player_attack_anim = $Attack_Projectile/PlayerAttackAnimation
@onready var state_machine = $StateMachine
@onready var player_animation = $AnimatedSprite2D
@onready var double_jump_animation = $DoubleJump
@onready var gm = $GameplayUI
@onready var dash_anim = $DashImpactAnim
@onready var lending_particles = $LandingParticles

#RayCasts
@onready var right_inner = $RayCasts/Right_Inner
@onready var right_outer = $RayCasts/Right_Outer
@onready var left_inner = $RayCasts/Left_Inner
@onready var left_outer = $RayCasts/Left_Outer

#CheckSafePosition
@onready var foot_left: RayCast2D = $CheckOfSafePosition/FootLeft
@onready var foot_right: RayCast2D = $CheckOfSafePosition/FootRight

var _grounded_time := 0.0
const SAFE_GROUND_TIME := 0.2

func _ready():
	var spawn = get_tree().get_first_node_in_group("spawn_point")
	if spawn:
		global_position = spawn.globadadl_position
	Global.player = self
	#$MainCamera.setup(self)
	state_machine.start()
	disable_attack_hitbox()
	
	"""
	double_jump_animation.visible = false
	double_jump_animation.animation_finished.connect(
		func(): double_jump_animation.visible = false
	)
	"""

func _physics_process(delta):
	tick_timers(delta)
	move_and_slide()
	if is_on_floor() and Input.is_action_just_pressed("move_down") \
	   and Input.is_action_just_pressed("jump"):
		drop_through()
	_update_safe_position(delta)


func _update_safe_position(delta: float) -> void:
	if is_on_floor():
		_grounded_time += delta
	else:
		_grounded_time = 0.0
		return

	var solid_footing := foot_left.is_colliding() and foot_right.is_colliding()
	if solid_footing and _grounded_time >= SAFE_GROUND_TIME:
		last_safe_position = global_position

func _input(event):
	if is_dead: return
	if event.is_action_pressed("ui_cancel") and not is_paused:
		is_paused = true
		PauseMenu.open($GameplayUI, self)

func handle_movement(delta: float) -> void:
	var input := Input.get_axis("move_left", "move_right")
	if input != 0.0:
		velocity.x = input * walk_velocity
	else:
		velocity.x = 0.0

func update_facing(input: float) -> void:
	if input != 0.0:
		input_direction = 1 if input > 0.0 else -1
		player_animation.flip_h = input > 0.0

func tick_timers(delta: float) -> void:
	coyote_timer = maxf(coyote_timer - delta, 0.0)
	jump_buffer_timer = maxf(jump_buffer_timer - delta, 0.0)

func grant_coyote() -> void:
	coyote_timer = coyote_time

func buffer_jump() -> void:
	jump_buffer_timer = jump_buffer_time

func consume_coyote_or_double() -> bool:
	if coyote_timer > 0.0:
		coyote_timer = 0.0
		return true
	if current_jumps > 0:
		return true
	return false

func consume_jump_buffer() -> bool:
	if jump_buffer_timer > 0.0:
		jump_buffer_timer = 0.0
		return true
	return false

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

func die() -> void:
	if is_dead: return
	is_dead = true
	DeadScreen.open(gm, self)
	Engine.time_scale = 0.0
	
func take_hazard_hit():
	if is_invincible: return
	Global.hp -= 1
	print(Global.hp)
	if Global.hp <= 0:
		DeadScreen.open(get_tree().root, self)
	else:
		respawn()

func respawn():
	is_invincible = true
	
	set_physics_process(false)
	set_process_input(false)

	var flash = _create_flash()
	var tween = create_tween()

	tween.tween_property(flash, "color:a", 1.0, 0.3)
	await tween.finished

	global_position = last_safe_position
	velocity = Vector2.ZERO

	tween = create_tween()
	tween.tween_property(flash, "color:a", 0.0, 0.4)
	await tween.finished

	flash.queue_free()
	set_physics_process(true)
	set_process_input(true)
	
	await get_tree().create_timer(1.0).timeout
	is_invincible = false
	
func _create_flash() -> ColorRect:
	var layer = CanvasLayer.new()
	layer.layer = 99
	var rect = ColorRect.new()
	rect.color = Color(0, 0, 0, 0)
	rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(rect)
	add_child(layer)
	return rect

func _on_attack_projectile_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.has_method("got_hurt"):
		body.got_hurt()

func enable_attack_hitbox():
	attack_hitbox_shape.disabled = false

func disable_attack_hitbox():
	attack_hitbox_shape.disabled = true

func drop_through() -> void:
	set_collision_mask_value(PLATFORM_LAYER, false)
	await get_tree().create_timer(0.15).timeout
	set_collision_mask_value(PLATFORM_LAYER, true)
