extends KinematicBody2D

var speed = 30; # base speed for all characters
var max_speed = 300; # base max_speed for all characters
var resistance = 0.1; # 0.1s

var hp = 10

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var player = get_parent().get_parent().get_node("Hero")

var path = []
var motion
var player_in_pov = false

export var enemy_speed = 0.8

func _process(delta):
	if hp <= 0:
		queue_free()

func _physics_process(delta):
	move()
	
func move():
	if  path.size() > 0:
		motion = (path[0] - position).normalized() * (max_speed * enemy_speed)
		move_and_slide(motion)
		
#		print(self.name, path)
		
		if path[0].x - position.x < 2 and path[0].y - position.y < 2:
			path.remove(0)
	
	if player_in_pov and path.size() < 3:
		make_path()

func make_path():
	path = navigation.get_simple_path(position, player.position, true)
	path.remove(0)
	


func _on_POV_body_entered(body):
	player_in_pov = true
	make_path()



func _on_POV_body_exited(body):
	player_in_pov = false
	path = [];


func _on_HitBox_body_entered(body):
#	print(body.name)
#	print(body.name, " ", navigation)
	if body.name == "Hero":
#		blocked = false
#		Global.hurt_player(body)
		pass
	elif body.name == "MapElements":
		pass
	elif body is KinematicBody2D:
		make_path()
#		blocked = false


func _on_Hero_move():
	if player_in_pov:
#		print("test")
		make_path()


func _on_HitBox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		# destroy byllet node
#		modulate = Color.white
#		motion = -motion * 4;
		hp -= 1
		area.get_parent().queue_free()
