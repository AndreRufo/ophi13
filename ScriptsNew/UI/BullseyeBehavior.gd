class_name BullseyeBehavior;
extends TextureRect

@onready var bullseye_locks = [$"bullseye-lock-botleft", $"bullseye-lock-botright", $"bullseye-lock-topleft", $"bullseye-lock-topright"];

@export var LockMoveSpeed = [1, 0.15, 1];	#[0-75], [75-95], [95-100]
var lock_progress : float = 0;
var visual_lock_progress : float = 0;

func _process(delta):
	if !Singletons.PlayerCharacter:
		return;
	position = Singletons.CameraObject.unproject_position((Singletons.PlayerCharacter.position)) - Vector2(32, 32);
	var progress_speed = 0;
	if(lock_progress < 0.5):
		progress_speed = LockMoveSpeed[0];
	elif(lock_progress > 0.5 && lock_progress < 0.75):
		progress_speed = LockMoveSpeed[1];
	else:
		progress_speed = LockMoveSpeed[2];
	
	visual_lock_progress = lerp(visual_lock_progress, lock_progress, delta * progress_speed);
	for e in bullseye_locks:
		e.position = e.start_position + e.TargetDirection * e.DistanceToTravel * lock_progress;
