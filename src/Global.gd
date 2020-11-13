extends Node

var hp = 5

func hurt_player():
	hp -= 1
	get_tree().call_group("player", "hurt")
	
	if hp < 0:
		end_game()
		

func end_game():
	get_tree().reload_current_scene()
	hp = 10
