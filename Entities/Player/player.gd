extends CharacterBody2D

@export var speed = 200
@export var jumpVelocity:float = -230.0
@export var dashVelocity:float = -500.0
@export var hp:int = 3
@export var is_midair:bool = false
var jumps = 2;

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		is_midair = true
		velocity += get_gravity() * delta
	else: 
		jumps = 2


	if Input.is_action_just_pressed("jump") and jumps != 0:
		velocity.y = jumpVelocity
		jumps -= 1

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		

	move_and_slide()
