extends Node

@onready var overlay: ColorRect     
@onready var label: Label           
@onready var anim: AnimationPlayer

signal cutscene_finished

func play_intro():
	Global.player.state_machine.transition_to("cutscene")
	
	# 1. Text na obrazovce
	overlay.modulate.a = 1.0
	label.text = "V roce 2XXX, technologie pohltila svět..."
	label.modulate.a = 0.0
	
	var tw = create_tween()
	tw.tween_property(label, "modulate:a", 1.0, 1.5)
	tw.tween_interval(2.5)
	tw.tween_property(label, "modulate:a", 0.0, 1.0)
	await tw.finished
	
	$DoorSound.play()
	await get_tree().create_timer(1.2).timeout
	
	tw = create_tween()
	tw.tween_property(overlay, "modulate:a", 0.0, 2.5)
	await tw.finished
	
	Global.player.state_machine.transition_to("idle")
	emit_signal("cutscene_finished")
