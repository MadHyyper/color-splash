extends Node2D

var levelNum = 0

func _ready():
	var levelName = get_tree().get_current_scene().get_name()
	
	if levelName == "Level0":
		levelNum = 0
	elif levelName == "Level1":
		levelNum = 1
	elif levelName == 'Level2':
		levelNum = 2
	elif levelName == 'Level3':
		levelNum = 3
	elif levelName == 'Level4':
		levelNum = 4
	elif levelName == 'Level5':
		levelNum = 5

func _on_exit_body_entered(body):
	levelNum = levelNum + 1
	get_tree().change_scene_to_file("res://Scenes/Levels/Level" + str(levelNum) + ".tscn")
