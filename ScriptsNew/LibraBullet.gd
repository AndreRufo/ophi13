extends Bullet

@export var BulletTurnRate : float = 15;

func _process(delta):
	direction = direction.rotated(Vector3.UP, deg_to_rad(BulletTurnRate * delta));
	super(delta);
