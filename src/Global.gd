extends Node

var hp = 5

var node_creation_parent = null

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func update_GUI():
	get_tree().call_group("GUI", "update_gui", hp)
	
func hurt_player():
	hp -= 1
	update_GUI()
	
	if hp < 0:
		end_game()
		
func end_game():
	get_tree().reload_current_scene()
	hp = 5
	update_GUI()
