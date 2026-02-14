extends Area2D
class_name Soul

var isHarvestable = false
signal soul_is_harestable()
@onready var soul_timer = $Timer 


func _ready() -> void:
	pass

func _soul_can_be_harvested():
	isHarvestable = true
	soul_timer.start()


func _on_body_entered(body: Node2D) -> void:
	print("one coing")
	queue_free()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	pass

func currency_at_one_spot():
	var player = Global.player
	pass
	#return {player.position.x, player.position.y}
