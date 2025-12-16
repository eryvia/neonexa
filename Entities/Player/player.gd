extends CharacterBody2D
class_name Player

@export var speed := 100.0
@export var jump_velocity := -600.0
@export var gravity := 900.0
@export var max_jumps := 2
var current_jumps := max_jumps
var facing_direction := 1  # 1 = right, -1 = left

@onready var state_machine = $StateMachine

func _ready():
	add_to_group("player")

func _physics_process(delta):
	state_machine._physics_process(delta)
	move_and_slide()
	
func update_facing(input):
	if input != 0:
		facing_direction = 1 if input > 0 else -1
		get_node("AnimatedSprite2D").flip_h = facing_direction == 1
		
func facing_direction_fn(input):
	if input > 0:
		return true
	elif input < 0:
		return false
	else:
		return self.facing_direction
