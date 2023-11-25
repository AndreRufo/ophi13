class_name BullseyeLockBehavior
extends TextureRect

@export var TargetDirection : Vector2;
@export var DistanceToTravel : float = 16;
var start_position : Vector2;

func _ready():
	start_position = position;

func reset():
	position = start_position;
