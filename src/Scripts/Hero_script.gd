extends KinematicBody2D

var speed = 30
var max_speed = 300
var resistance = 0.10
var can_shoot = true

var motion = Vector2()

var bullet = preload("res://Objects/Hero/Bullet.tscn")

signal move

func _process(delta):
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false

func _physics_process(delta):
	update_movement()
	play_animation()
	move_and_slide(motion)

func update_movement():
	if Input.is_action_pressed("player_down") and not Input.is_action_pressed("player_up"):
		motion.y = clamp(motion.y + speed, 0, max_speed)
		emit_signal("move")
	elif Input.is_action_pressed("player_up") and not Input.is_action_pressed("player_down"):
		motion.y = clamp(motion.y - speed, -max_speed, 0)
		emit_signal("move")
	else:
		motion.y = lerp(motion.y, 0, resistance)
		
	if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		motion.x = clamp(motion.x - speed, -max_speed, 0)
		emit_signal("move")
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = true;
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left"):
		motion.x = clamp(motion.x + speed, 0, max_speed)
		emit_signal("move")
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = false;
	else:
		motion.x = lerp(motion.x, 0, resistance)
#		$AnimatedSprite.play("Mage_idle")

func play_animation():
	if Input.is_action_pressed("player_down") or Input.is_action_pressed("player_up"):
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true;
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left"):
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false;
	else:
		$AnimatedSprite.play("Mage_idle")

#Shooting bullet

func hurt(body):
	pass
#	print("enemy: ", body.position, " player: ", global_position)
#	print(body.position.x - global_position.x)
#	var diff = body.position.x - global_position.x
#	if body.position.x > global_position.x + 15:
#		print("test 1")
#		motion.x = max_speed * 3
#	if body.position.x < global_position.x + 15:
#		print("test 2")
#		motion.x = -max_speed * 10
#	motion += (global_position - body.position) * max_speed
#	print("motion: ", motion)


func _on_Hitbox_body_entered(body):
	print("enemy: ", body.position, " player: ", global_position)
	print(body.position.x - global_position.x)
	
	if body.is_in_group("Enemies"):
		motion = (global_position - body.position) * (speed * 0.8)
		Global.hurt_player()
	
	print("motion: ", motion)
	print("body_name: ", body.name)


func _on_Reload_speed_timeout():
	can_shoot = true
