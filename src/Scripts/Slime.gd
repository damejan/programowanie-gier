extends KinematicBody2D

export var can_shot_to_player = false

export var speed = 220;
var resistance = 0.1; # 0.1s
var hp = 10

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var player = get_tree().get_root().find_node("Hero", true, false)
var bullet = preload("res://Objects/Bullet_enemy.tscn")

var path
var active = false
var can_shoot = true



func _ready():
	update_path(position, player.position)
	print("test from slime ready: ", name)

func _process(delta):
	if active:
		var walk_distance = speed * delta
		move_along_path(walk_distance)
		
		if can_shot_to_player:
			if Global.node_creation_parent != null and can_shoot:
				Global.instance_node(bullet, global_position, Global.node_creation_parent)
				$Can_shoot.start()
				can_shoot = false;


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
			move_and_slide((path[0] - position).normalized() * speed)
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
	elif body.is_in_group("Player"):
		pass
#		print(get_parent().get_node(body.name).name)
#		get_parent().get_node(body.name).speed -= 20;

func _on_HitBox_body_exited(body):
	print("on_exited: ", body, " ", body.name)
	if body.is_in_group("Enemies"):
		pass
#		print(get_parent().get_node(body.name).name)
#		get_parent().get_node(body.name).speed = 250;

func _on_HitBox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		hp -= 1
		$Particles2D.emitting = true
		$AudioStreamPlayer.play()
		area.get_parent().queue_free()
		if hp < 0:
			Global.add_score(1);
			get_parent().get_parent().enemy_killed()
			queue_free();

func _on_Can_shoot_timeout():
	can_shoot = true
