extends Node

const GAME_SCENES: Dictionary = {
	"player": "uid://brles2brqiwmx",
	"sandbox": "uid://c80maj2vdho5i",
	"mainScene": "uid://dn0d1brp825vr",
	"Prologue": "uid://c04it1lgwtnka",
	"PauseMenu": "uid://cadg2taeq3c3a",
	"DeadScreen": "uid://bptiq5u0gd20a"
}

var souls = 0
var hp_fragments = 5
var player: Node2D

func call_current_state(current_state):
	print(current_state)
	

	
	
