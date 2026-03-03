extends HBoxContainer

@onready var max_health = Global.hp_fragments
var current_health = 5
var last_health = current_health

@export var fragment_scene: PackedScene 


func _ready():
	setup_health()

func setup_health():
	for child in get_children(): #cutting all hp before
		child.queue_free()
	
	for i in range(max_health):
		var hp_frag = fragment_scene.instantiate()
		add_child(hp_frag)

func take_damage(amount: int):
	for i in range(amount):
		if current_health > 0:       
			if i > 1: 
				get_tree().create_timer(1.2).timeout
			var frag_to_break = get_child(current_health - 1)
			frag_to_break.play_break()
			current_health -= 1

func heal(amount: int):
	for i in range(amount):
		if current_health < max_health:
			var frag_to_fill = get_child(current_health)
			frag_to_fill.play_fill_animation()
			current_health += 1
