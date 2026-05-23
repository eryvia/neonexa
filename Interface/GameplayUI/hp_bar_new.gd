extends Control

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const HIT_ANIMS = ["1st_hit", "2nd_hit", "3rd_hit", "4th_hit", "5th_hit"]

func _ready():
	Global.hp_changed.connect(_on_hp_changed)
	_on_hp_changed(Global.hp) 

func _on_hp_changed(new_hp: int):
	var hits_taken = Global.max_hp - new_hp  
	if hits_taken > 0:
		sprite.play(HIT_ANIMS[hits_taken - 1])
	sprite.frame = Global.max_hp - new_hp  
