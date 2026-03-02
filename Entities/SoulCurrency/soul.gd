extends Area2D
class_name Soul

var isHarvestable = false
var is_harvestable := false
@onready var soul_timer: Timer = $Timer


func _ready() -> void:
	SignalBus.soul_can_be_harvested.connect(_on_soul_can_be_harvested)

func _on_soul_can_be_harvested() -> void:
	is_harvestable = true
	soul_timer.start()

func _on_body_entered(body: Node2D) -> void:
	Global.souls += 1
	queue_free()
	pass

func _on_timer_timeout() -> void:
	pass

func currency_at_one_spot():
	var player = Global.player
	pass
	#return {player.position.x, player.position.y}
