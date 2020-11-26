extends CanvasLayer

func _ready():
	$Control/HBoxContainer/Label.text = str(Global.hp)
	
func update_gui(hp):
	$Control/HBoxContainer/Label.text = str(hp)
