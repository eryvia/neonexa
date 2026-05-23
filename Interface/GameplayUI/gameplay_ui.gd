extends CanvasLayer

@onready var souls = Global.souls
@onready var soulsUI = $Label 

func _ready() -> void:
	soulsUI.text = str(Global.souls)
	SignalBus.souls_changed.connect(_on_souls_changed)
	$AnimatedSprite2D.play("default")
	
func _on_player_health_changed(amount: Variant) -> void:
	$HPBar.take_damage(amount)
	pass 

func _on_souls_changed(amount: int) -> void:
	soulsUI.text = str(amount)
