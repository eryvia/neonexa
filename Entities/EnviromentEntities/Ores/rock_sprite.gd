extends AnimatedSprite2D

func advance_frame():
	var current = frame

	var total_frames = sprite_frames.get_frame_count(animation)
	var next_frame = (current + 1) % total_frames

	frame = next_frame

	print("Moved from frame ", current, " to ", frame)
