extends StaticBody2D

var doors_closed = preload("res://Graphics/Tilesets/Map_elements/doors/doors_closed.png")
var doors_closed_arc = preload("res://Graphics/Tilesets/Map_elements/doors/doors_closed_arc.png")

var doors_opened = preload("res://Graphics/Tilesets/Map_elements/doors/doors_open.png")
var doors_opened_arc = preload("res://Graphics/Tilesets/Map_elements/doors/doors_open_arc.png")

func open_door():
	$core_door/CollisionShape2D.disabled = true;
	$Sprite.texture = doors_opened
	$Sprite_arc.texture = doors_opened_arc
	$Sprite_arc.z_index = 2;
	
func close_door():
	$core_door/CollisionShape2D.disabled = false;
	$Sprite.texture = doors_closed
	$Sprite_arc.texture = doors_closed_arc
	$Sprite_arc.z_index = 2;
