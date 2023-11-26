extends Bullet

@export var SpeedCurveFront : Curve;
@export var SpeedCurveSideways : Curve;

func _process(delta):
	var currCurveValue = $Timer.time_left / $Timer.wait_time;
	var newDir = direction * speed * SpeedCurveFront.sample(currCurveValue);
	var dirRotated = newDir.rotated(Vector3.UP, deg_to_rad(90));
	
	var finalDir = newDir + SpeedCurveSideways.sample(currCurveValue) * dirRotated;
	
	position += finalDir * delta;
	currCurveValue += delta * 0.1;
