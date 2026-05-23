extends State
class_name FreezeState

func enter():
	player.velocity = Vector2.ZERO

func handle_input(_event):
	pass  # blokuje veškerý input

func physics_update(_delta):
	# gravity možná nechat, možná ne - záleží na scéně
	pass

func exit():
	pass
