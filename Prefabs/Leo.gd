extends BaseEnemy

@export var AngleCurve : Curve;
var currentCurveVal = 0;

func _ready():
	Speed = 0.2
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.1);
		
	$AnimationPlayer2.play("leoshoot")

func _update(delta):
	$BulletSpawnersContainer.rotate_y(0.05);
	
	var moveDir = AngleCurve.sample(currentCurveVal);
	currentCurveVal += delta * 0.1;
	
	var direction : Vector3 = (player.position - position)
	var new_velocity = (player.position - position) * Speed
	var sideways_dir = global_transform.basis.x * moveDir * 5;
	velocity.x = new_velocity.x + sideways_dir.x
	velocity.z = new_velocity.z + sideways_dir.z
	
	var new_look_dir = position + direction
	
	if (direction.length() > 0):
		look_at(new_look_dir, Vector3.UP, true)
	pass
