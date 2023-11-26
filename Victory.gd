extends Node3D

func _ready():
	$AnimationPlayer.play("loop")
	$SexyDance/AnimationPlayer.play("Armature|mixamo_com|Layer0_001")
