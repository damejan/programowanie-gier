extends KinematicBody2D

onready var anim = $AnimatedSprite
var hp = 5

func _process(delta):
	if global_position.normalized().y > 0:
		anim.play("default")
		anim.flip_h = false
	else:
		anim.play("default")
		anim.flip_h = true
		
	print(global_position.normalized())


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		hp -= 1
		$Particles2D.emitting = true;
		area.get_parent().queue_free()
#		get_parent().get_parent().find_node("Doors").open_door()
		if hp < 0:
			Global.add_score(2);
			get_parent().get_parent().enemy_killed()
			queue_free();


#DO NAPRAWY SMIERC SMOKA
