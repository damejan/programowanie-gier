extends Node

var initial_hp = 6
var hp = initial_hp

var score = 0
var highest_score = 0

var node_creation_parent = null

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
