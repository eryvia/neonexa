extends CharacterBody2D
class_name Guard

@export var speed := 120.0
var target: Node2D = null
var facing_direction = 1
var hp = 4

@onready var state_machine = $StateMachine
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	state_machine._physics_process(delta)

	
"""
func _facing_direction():	
	animation.flip_h
"""
"""
func _on_hit_box_area_entered(area: Area2D) -> void:
	if area == is_in_group(player_attack):
		pass
	pass # Replace with function body.
	
	
"""
