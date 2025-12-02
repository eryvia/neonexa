extends CharacterBody2D
class_name Player

@export var speed := 200.0
@export var jump_velocity := -230.0
@export var gravity := 900.0
@export var jumps := 2
var facing_direction := 1  # 1 = right, -1 = left

@onready var state_machine = $StateMachine

func _ready():
	add_to_group("player")

func _physics_process(delta):
	state_machine._physics_process(delta)
	move_and_slide()
