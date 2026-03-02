extends Control

@onready var souls = Global.souls
@onready var soulsUI = $Label 

func _ready() -> void:
	soulsUI.text = str(souls)
	
	
