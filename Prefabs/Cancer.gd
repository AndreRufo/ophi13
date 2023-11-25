extends BaseEnemy

@export var AngleCurve : Curve;
@export var AngleCurve2 : Curve

var currentCurveVal = 0;

func _ready():
	Speed = 0.1
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.05);
		
	var spawners2 = $BulletSpawnersContainer2.get_children();
	for spawner in spawners2:
		spawner.SetSpawnInterval(0.05);
		
	$AnimationPlayer.play("cancershoot")

func _update(delta):
	var rotAngle = AngleCurve.sample(currentCurveVal);
	$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	var rotAngle2 = AngleCurve2.sample(currentCurveVal);
	$BulletSpawnersContainer2.rotate_y(deg_to_rad(rotAngle2));
	currentCurveVal += delta * 0.1;
	
	var direction : Vector3 = (player.position - position)
	var new_velocity = (player.position - position) * Speed
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	
	var new_look_dir = position + direction
	
	if (direction.length() > 0):
		look_at(new_look_dir, Vector3.UP, true)
	pass
