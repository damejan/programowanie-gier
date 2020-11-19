extends CanvasLayer

func _ready():
	$Control/HBoxContainer/Label.text = str(Global.hp)
	
func update_gui(hp):
	$Control/HBoxContainer/Label.text = str(hp)
	
#func create_hearts():
#	var heart = TextureRect.new()
#	heart.rect_size = Vector2(20, 20)
#	heart.expand = true
#	heart.texture = StreamTexture.new()
#	heart.texture.resource_path = "res://GFX/Hp.png"
#
#	for i in range(Global.hp-1):
#		$Control.add_child(heart)
#		print(i)
