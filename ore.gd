extends Area2D
class_name Ore

signal OreHit

@export var hp = 4
@export var amount_soul = randi_range(1, 6)
@onready var RockSprite = $RockSprite 
@onready var CurrencyDrop = $CurrencyDropPoint 

func _ready() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack"):
		OreHit.emit()
		hp -= 1
		if hp == 0:
			queue_free()
		
func _on_ore_hit() -> void:
	RockSprite.advance_frame()
	CurrencyDrop.currency_drop(hp)
