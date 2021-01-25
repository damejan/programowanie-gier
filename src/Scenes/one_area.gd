extends Node

onready var enemy_count = $Enemies.get_child_count()
onready var door = $Doors

func _ready():
	pass

func enemy_killed():
	enemy_count -= 1;
	if enemy_count == 0:
		if door:
			door.open_door();
		else:
			get_tree().change_scene(Global.random_level())


func _on_AreaActivator_area_entered(area):
	print("asdf area entered: ", area.name)
	var enemies = $Enemies.get_children()
	var camera_pos = $camera_limit_position
	get_tree().call_group("Player_camera", "change_top_limit", camera_pos.position.y)
	for enemy in enemies:
		print("asdf: ", enemy.name)
		if enemy.name != "Path_and_dragon":
			enemy.active = true
	$AreaActivator.queue_free()
