extends "res://Characters/Character_template.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var player = get_parent().get_parent().get_node("Player")

var path = []
var motion
var player_in_pov = false
var current_point
#var blocked = false

export var enemy_speed = 0.5

func _physics_process(delta):
	move()
	

func move():
	if  path.size() > 0:
		# print("test")
		motion = (path[0] - position).normalized() * (max_speed * enemy_speed)
		#print(position, path[0])
		#look_at(path[0])
		move_and_slide(motion)
		
		#print("(", int(path[0].x), ",", int(path[0].y), "), (", int(position.x),",", int(position.y), ")", player_in_pov)
		#print(path, path.size())
		#print(motion, path[0])
		print(self.name, path)
#		print(self.name, blocked)
		
		if path[0].x - position.x < 2 and path[0].y - position.y < 2:
			#print("(", int(path[0].x), ",", int(position.x), "), (", int(path[0].y),",", int(position.y), ")", player_in_pov)
			#print(path)
			path.remove(0)
			
	
#	if is_on_wall():
#		#print("test")
#		make_path()
#	if blocked:
		#var current_point = path[0]
#		path = []
#		path.insert(0, Vector2(-position.x * 0.5, -position.y * 0.5))
#		blocked = false
	
	if player_in_pov and path.size() < 3:
		make_path()

func make_path():
	path = navigation.get_simple_path(position, player.position, true)
	path.remove(0)

func _on_POV_body_entered(body):
	player_in_pov = true
#	path = navigation.get_simple_path(position, player.position, false)
#	path.remove(0)
	make_path()
	#print(player)
	#print(path)


func _on_POV_body_exited(body):
	player_in_pov = false
	path = [];


func _on_Player_move():
	if player_in_pov:
		print("test")
		make_path()


func _on_HitBox_body_entered(body):
	print(body.name)
	print(body.name, " ", navigation)
	if body.name == "Player":
#		blocked = false
		Global.hurt_player()
	elif body.name == "TileMapItems":
#		blocked = true
#		path.insert(0, current_point)
#		path = []
#		path.insert(0, Vector2(-position.x * 0.5, -position.y * 0.5))
#		print(body.position)
#		make_path()
		pass
	elif body is KinematicBody2D:
		make_path()
#		blocked = false
