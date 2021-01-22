extends KinematicBody2D

onready var anim = $AnimatedSprite

func _process(delta):
	if global_position.normalized().y > 0:
		anim.play("default")
		anim.flip_h = false
	else:
		anim.play("default")
		anim.flip_h = true
		
	print(global_position.normalized())
