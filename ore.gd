extends Area2D
class_name Ore

signal OreHit

@export var hp = 4 
@export var amount_soul = 5
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
	RockSprite.advance_frame(amount_soul)
	CurrencyDrop.currency_drop(hp)
