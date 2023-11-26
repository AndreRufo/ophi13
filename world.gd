extends Node3D

func _process(delta):
	if Singletons.NumEnemiesDefeated >= 13:
		get_tree().change_scene_to_file("res://Victory.tscn")
