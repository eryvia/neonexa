extends CharacterBody2D

signal TargetEntered

@export var run_speed := 50.0
@export var attack_range := 30.0
@export var leap_range := 150.0  
@export var attack_cooldown_time := 1.2
var can_attack := true
@export var launch_time: float = 1.2
@export var speed := 200.0
var target: Node2D = null
var facing_direction = 1
var hp = 1
var isAttacking = false 
var isDetecting := false


@onready var DetectionArea = $DetectionArea
@onready var state_machine = $StateMachine
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	state_machine._physics_process(delta)

func _on_detection_area_body_entered(body: Node2D) -> void:
	print("something entered: ", body.name)
	print("is player group: ", body.is_in_group("player"))
	
	if !body.is_in_group("player"):
		return
	
	print("jumper detects player!")
	isDetecting = true
	target = body
