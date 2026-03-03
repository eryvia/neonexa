extends CharacterBody2D

signal TargetEntered

@export var launch_time: float = 1.2
@export var speed := 200.0
var target: Node2D = null
var facing_direction = 1
var hp = 6
var isAttacking = false 
var isDetecting := false


@onready var DetectionArea = $DetectionArea
@onready var state_machine = $StateMachine
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	state_machine._physics_process(delta)

func _on_detection_area_body_entered(body: Node2D) -> void:
	print("jumper detects player")
	isDetecting = true
	TargetEntered.emit()
	target = body
	pass 
