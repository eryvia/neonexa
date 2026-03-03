extends State
class_name PursueState

func enter():
	Global.call_current_state(self)
	var animation = parent.get_node("AnimatedSprite2D")
	animation.play("attack")

func physics_update(delta):
	var direction = owner.target.global_position - owner.global_position
	var animation = parent.get_node("AnimatedSprite2D")
	if direction.x > 0:
		animation.flip_h = 1
		
	print(direction)
	owner.velocity = direction.normalized() * owner.speed * delta

	owner.move_and_slide()
	
	_choosing_next_state(direction)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == parent.target:
		parent.target = null
		Transitioned.emit(self, "EnemyIdleState")


func _choosing_next_state(direction):
	if direction.x < 3:
		Transitioned.emit(self, "AttackStateEnemy")
	

func _on_attack_area_body_entered(body: Node2D) -> void:
	Transitioned.emit(self, "AttackState")
	pass
	 
