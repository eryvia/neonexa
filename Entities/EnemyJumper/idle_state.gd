extends State
class_name EnemyIdleState

func enter():
	print("IdleState", self)
	parent.get_node("AnimatedSprite2D").play("idle")

func physics_update(delta: float) -> void:
	if parent.isDetecting:
		Transitioned.emit(self, "EnemyRunState")
		
		
