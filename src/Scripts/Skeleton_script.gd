extends KinematicBody2D

export var speed = 180; # base speed for all characters
#var max_speed = 300; # base max_speed for all characters
var resistance = 0.1; # 0.1s

var hp = 10

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var player = get_parent().get_parent().get_node("Hero")

var path


func _ready():
	update_path(position, player.position)
	print("test from slime ready: ", name)

func _process(delta):
	var walk_distance = speed * delta
	move_along_path(walk_distance)


func update_path(start_position, end_position):
	path = navigation.get_simple_path(start_position, end_position, true)
	path.remove(0)
#	set_process(true)

func move_along_path(distance):
	var last_point = position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
#			position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			var normalized_vector = (path[0] - position).normalized()
#			print(normalized_vector)
			move_and_slide(normalized_vector * speed)
			
			if normalized_vector.x > 0:
				$AnimatedSprite.play("Skeleton_run")
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.play("Skeleton_run")
				$AnimatedSprite.flip_h = true
				
			return
		# The position is past the end of the segment.
#		print("distance: ", distance, " distance_between_points: ", distance_between_points)
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
		
	if path.size() == 0:
		update_path(position, player.position)
	# The character reached the end of the path.
	position = last_point
#	set_process(false)
	

func player_moved_change_path():
	update_path(position, player.position)

func _on_HitBox_body_entered(body):
	print("on_entereed: ", body, " ", body.name)
	if body.is_in_group("Enemies"):
		pass
#		print(get_parent().get_node(body.name).name)
#		get_parent().get_node(body.name).speed -= 20;

func _on_HitBox_body_exited(body):
	print("on_exited: ", body, " ", body.name)
	if body.is_in_group("Enemies"):
		pass
#		print(get_parent().get_node(body.name).name)
#		get_parent().get_node(body.name).speed = 250;

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		hp -= 1
		$Particles2D.emitting = true;
		$AudioStreamPlayer.play()
		area.get_parent().queue_free()
		if hp < 0:
			queue_free();

#var speed = 30; # base speed for all characters
#var max_speed = 300; # base max_speed for all characters
#var resistance = 0.1; # 0.1s
#
#var hp = 10
#
#onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
#onready var player = get_parent().get_parent().get_node("Hero")
#
#var path = []
#var motion
#var player_in_pov = false
#
#export var enemy_speed = 0.8
#
#func _process(delta):
#	if hp <= 0:
#		queue_free()
#
#func _physics_process(delta):
#	move()
#
#func move():
#	if  path.size() > 0:
#		motion = (path[0] - position).normalized() * (max_speed * enemy_speed)
#		move_and_slide(motion)
#
##		print(self.name, path)
#
#		if path[0].x - position.x < 2 and path[0].y - position.y < 2:
#			path.remove(0)
#
#	if player_in_pov and path.size() < 3:
#		make_path()
#
#func make_path():
#	path = navigation.get_simple_path(position, player.position, true)
#	path.remove(0)
#
#
#
#func _on_POV_body_entered(body):
#	player_in_pov = true
#	make_path()
#
#
#
#func _on_POV_body_exited(body):
#	player_in_pov = false
#	path = [];
#
#
#func _on_HitBox_body_entered(body):
##	print(body.name)
##	print(body.name, " ", navigation)
#	if body.name == "Hero":
##		blocked = false
##		Global.hurt_player(body)
#		pass
#	elif body.name == "MapElements":
#		pass
#	elif body is KinematicBody2D:
#		make_path()
##		blocked = false
#
#
#func _on_Hero_move():
#	if player_in_pov:
##		print("test")
#		make_path()
#
#
#func _on_HitBox_area_entered(area):
#	if area.is_in_group("Enemy_damager"):
#		# destroy byllet node
##		modulate = Color.white
##		motion = -motion * 4;
#		hp -= 1
#		area.get_parent().queue_free()
