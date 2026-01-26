extends State
class_name AttackStateddw

func enter():
	var weight:int
	var timer: Timer = $GLSlashTimer
	var attacks = [
		{"func": "GroundLongSlash", weight: 90 },
		{"func": "Regularc", weight: 10 } 
	]
	choose_attack(attacks)
	owner.isAttacking = true
	

func physics_update(delta):
	if owner.isAttacking:
		owner.velocity.x = owner.facing * 200

func GroundLongSlash(): 
	owner.position.x = 0
	
func choose_attack(attacks):
	var total = 0
	for a in attacks:
		total += a.weight
	
	var roll = randi() % total
	var acc = 0
	
	for a in attacks:
		acc += a.weight
		if roll < acc:
			call(a.func)
			return
	
