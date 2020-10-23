extends "res://Characters/Character_template.gd"

var motion = Vector2()

func _physics_process(delta):
	update_movement()
	move_and_slide(motion)
	
func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("player_down") and not Input.is_action_pressed("player_up"):
		motion.y = clamp(motion.y + speed, 0, max_speed)
	elif Input.is_action_pressed("player_up") and not Input.is_action_pressed("player_down"):
		motion.y = clamp(motion.y - speed, -max_speed, 0)
	else:
		# lerp - linear interpolate
		motion.y = lerp(motion.y, 0, resistance)
		
	if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		motion.x = clamp(motion.x - speed, -max_speed, 0)
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left"):
		motion.x = clamp(motion.x + speed, 0, max_speed)
	else:
		motion.x = lerp(motion.x, 0, resistance)
