extends Control

@onready var souls = Global.souls
@onready var soulsUI = $Label 

func _ready() -> void:
	soulsUI.text = str(souls)
	
func _on_player_health_changed(amount: Variant) -> void:
	$HPBar.take_damage(amount)
	pass 
