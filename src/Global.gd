extends Node

var initial_hp = 6
var hp = initial_hp

var score = 0
var highest_score = 0

var node_creation_parent = null

var player_position = Vector2(0, 0);

var levels = [
	"res://Scenes/Levels/Lv1.tscn",
	"res://Scenes/Levels/Lv2.tscn",
	"res://Scenes/Levels/Lv3.tscn",
	"res://Scenes/Levels/Lv4.tscn",
	"res://Scenes/Levels/Lv5.tscn",
	"res://Scenes/Main.tscn"
]

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func update_GUI():
	get_tree().call_group("GUI", "update_hp", hp)
	
func hurt_player():
	hp -= 1
	update_GUI()
	
	if hp == 0:
		end_game()
		
func add_score(value):
	score += value
	if score > highest_score:
		highest_score = score;
	get_tree().call_group("GUI", "update_score")
		
func end_game():
	get_tree().reload_current_scene()
	score = 0
	hp = initial_hp
	update_GUI()
	get_tree().call_group("GUI", "update_score")
	

func volume_down():
	if $Background_music.volume_db >= -80:
		$Background_music.volume_db -= 1

func volume_up():
	if $Background_music.volume_db <= 24:
		$Background_music.volume_db += 1

#func get_random_numbers(from, to):
#    var arr = []
#    for i in range(from,to):
#        arr.append(i)
#    arr.shuffle()
#    return arr

func random_level():
	return levels[0 + randi() % (len(levels) - 0)]
