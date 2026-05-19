extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State
var previous_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transform)
			
	var parent = get_parent()
	if parent is Player:
		for state in states.values():
			state.player = parent
	else: 
		for state in states.values():
			state.parent = parent
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
	print("registered states: ", states.keys())
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transform(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("FAILED: ", get_parent().name, " tried to find '", new_state_name, "' in ", states.keys())
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
	#hello
	
func change_state(new_state_name: String):
	on_child_transform(current_state, new_state_name)
