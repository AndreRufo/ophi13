extends BaseEnemy

@export var AngleCurve : Curve;
var firstHits : int = 3

var currentCurveVal = 0;
var twin : Node3D
var twinsSpeed = 0.3

func _ready():
	Speed = 0.1
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.1);

func _update(delta):
	var rotAngle = AngleCurve.sample(currentCurveVal);
	$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	currentCurveVal += delta * 0.1;
	
	if twin != null && (twin.position - position).length() <= 10 :
		var new_velocity = (position - twin.position) * Speed
		velocity.x = new_velocity.x
		velocity.z = new_velocity.z
	else :
		var direction : Vector3 = (player.position - position)
		var new_velocity = (player.position - position) * Speed
		velocity.x = new_velocity.x
		velocity.z = new_velocity.z
	
	if MaxHealth - currentHealth >= firstHits:
		_split()
		queue_free()
	
	pass

func _split():
	print("spawned gemini")
	var new_sign : Node3D = self.duplicate();
	get_parent().add_child(new_sign);
	new_sign.position.x += 1
	var new_sign_2 : Node3D = self.duplicate();
	get_parent().add_child(new_sign_2);
	new_sign_2.position.x -= 1
	new_sign.currentHealth = 7
	new_sign_2.currentHealth = 7
	new_sign.firstHits = 100
	new_sign_2.firstHits = 100
	new_sign.twin = new_sign_2
	new_sign_2.twin = new_sign
	new_sign.Speed = twinsSpeed
	new_sign_2.Speed = twinsSpeed
