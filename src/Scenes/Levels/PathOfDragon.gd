extends Path2D

func _physics_process(delta):
#	print($PathFollow2D.h_offset)
	$PathFollow2D.set_offset($PathFollow2D.get_offset()+200*delta)
