extends Node

const GAME_SCENES: Dictionary = {
	"player": "uid://brles2brqiwmx",
	"sandbox": "uid://c80maj2vdho5i",
	"mainScene": "uid://dn0d1brp825vr",
	"PauseMenu": "uid://cadg2taeq3c3a"
}

var souls = 0
var hp_fragments = 5
var player: Node2D

func call_current_state(current_state):
	print(current_state)
	
	
