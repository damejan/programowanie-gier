extends Node

var hp = 5

func update_GUI():
	get_tree().call_group("GUI", "update_gui", hp)

func hurt_player():
	hp -= 1
	get_tree().call_group("player", "hurt")
	update_GUI()
	
	
	
	if hp < 0:
		end_game()
		

func end_game():
	get_tree().reload_current_scene()
	hp = 5
	update_GUI()
