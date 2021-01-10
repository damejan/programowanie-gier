extends KinematicBody2D

var speed = 30
var max_speed = 300
var resistance = 0.10
var can_shoot = true

var motion = Vector2()

var bullet = preload("res://Objects/Hero/Bullet.tscn")

signal move

var enemy_in_hitbox = false;
var static_enemy_in_hitbox = false;

func _ready():
	set_collision_mask_bit(1, true)
	$Hitbox/CollisionShape2D.disabled = false;

func _process(delta):
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false
	
	if Input.is_action_pressed("test1"):
		get_tree().call_group("Door", "open_door")
		
	if Input.is_action_pressed("test2"):
		get_tree().call_group("Door", "close_door")

func _physics_process(delta):
	update_movement()
	play_animation()
	move_and_slide(motion)

func update_movement():
	if Input.is_action_pressed("player_down") and not Input.is_action_pressed("player_up"):
		motion.y = clamp(motion.y + speed, 0, max_speed)
		emit_signal("move")
		get_tree().call_group("Enemies", "player_moved_change_path")
	elif Input.is_action_pressed("player_up") and not Input.is_action_pressed("player_down"):
		motion.y = clamp(motion.y - speed, -max_speed, 0)
		emit_signal("move")
		get_tree().call_group("Enemies", "player_moved_change_path")
	else:
		motion.y = lerp(motion.y, 0, resistance)
		
	if Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
		motion.x = clamp(motion.x - speed, -max_speed, 0)
		emit_signal("move")
		get_tree().call_group("Enemies", "player_moved_change_path")
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = true;
	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left"):
		motion.x = clamp(motion.x + speed, 0, max_speed)
		emit_signal("move")
		get_tree().call_group("Enemies", "player_moved_change_path")
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = false;
	else:
		motion.x = lerp(motion.x, 0, resistance)
#		$AnimatedSprite.play("Mage_idle")

func play_animation():
	if motion.x > 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false;
	elif motion.x < 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true;
	else:
		$AnimatedSprite.play("Mage_idle")
		
#	if Input.is_action_pressed("player_down") or Input.is_action_pressed("player_up"):
#		$AnimatedSprite.play("run")
#	elif Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right"):
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = true;
#	elif Input.is_action_pressed("player_right") and not Input.is_action_pressed("player_left"):
#		$AnimatedSprite.play("run")
#		$AnimatedSprite.flip_h = false;
#	else:
#		$AnimatedSprite.play("Mage_idle")

#Shooting bullet

func hurt(body):
	motion = (global_position - body.position) * (speed * 0.8)
#	get_tree().call_group("Enemies", "player_moved_change_path")
	Global.hurt_player()
	$AnimationPlayer.play("hurt")

func hurt_from_area():
	Global.hurt_player()
	$AnimationPlayer.play("hurt")

func _on_Hitbox_body_entered(body):
	print("enemy: ", body.position, " player: ", global_position)
	print(body.position.x - global_position.x)
	
	if body.is_in_group("Enemies"):
		hurt(body)
		enemy_in_hitbox = true;
		$Enemy_in_hitbox.start()
	
	print("motion: ", motion)
	print("body_name: ", body.name)


func _on_Hitbox_body_exited(body):
	if body.is_in_group("Enemies"):
		enemy_in_hitbox = false

func _on_Reload_speed_timeout():
	can_shoot = true

func _on_Enemy_in_hitbox_timeout():
	if enemy_in_hitbox:
		hurt(self)
	if static_enemy_in_hitbox:
		hurt_from_area()

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player_damager"):
		hurt_from_area()
		static_enemy_in_hitbox = true;
		$Enemy_in_hitbox.start()


func _on_Hitbox_area_exited(area):
	if area.is_in_group("Player_damager"):
		static_enemy_in_hitbox = false
