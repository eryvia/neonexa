extends Control

func play_break():
	$SoulFragment.play("break")
	await $SoulFragment.animation_finished 
	queue_free() 

func play_fill():
	self.visible = true
	$SoulFragment.play("fill_animation")
