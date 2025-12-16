extends CharacterBody2D

@export var speed := 120.0
var target: Player = null

@onready var state_machine = $StateMachine
