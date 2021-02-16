extends KinematicBody2D

export var speed = 180;
var resistance = 0.1; # 0.1s

var hp = 2

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var player = get_tree().get_root().find_node("Hero", true, false)

var path
var active = false


func _ready():
	update_path(position, player.position)
	print("test from slime ready: ", name)

func _process(delta):
	if active:
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
#		get_parent().get_parent().find_node("Doors").open_door()
		if hp < 0:
			Global.add_score(2);
			get_parent().get_parent().enemy_killed()
			queue_free();
