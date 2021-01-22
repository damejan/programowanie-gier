extends CanvasLayer

onready var hearts_empty = $Control/HPContainer/HPIconEmpty;
onready var hearts_full = $Control/HPContainer/HPIconFull;

func _ready():
#	$Control/HBoxContainer/Label.text = str(Global.hp)
	set_max_hearts()
	set_hearts(Global.hp);
	$Control/VBoxContainer/Score.text = 'Score: ' + str(Global.score)
	$Control/VBoxContainer/HighestScore.text = 'Highest Score: ' + str(Global.highest_score)
	
func update_hp(hp):
#	$Control/HBoxContainer/Label.text = str(hp)
	set_hearts(hp);
	
func update_score():
	$Control/VBoxContainer/Score.text = 'Score: ' + str(Global.score)
	$Control/VBoxContainer/HighestScore.text = 'Highest Score: ' + str(Global.highest_score)


func set_hearts(value):
	hearts_full.rect_size.x = Global.hp * 15 

func set_max_hearts():
	hearts_empty.rect_size.x = Global.initial_hp * 15
