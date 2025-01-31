extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level0.tscn")



func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")


func _on_exit_pressed():
	get_tree().exit()
	
