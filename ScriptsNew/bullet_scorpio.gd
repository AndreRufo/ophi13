extends Bullet

var newDir : Vector3
var startSpeed : float 
var oldDiffToTarget : Vector3

var chilling : bool = false 

func _ready():
	speed = 1
	startSpeed = speed
	
func _process(delta):
	if !Singletons.PlayerCharacter:
		return;
	var newDir
	if chilling :
		newDir = lerp(direction, oldDiffToTarget, 1);
	else :
		newDir = direction;
	
		var realDifToTarget = (Singletons.PlayerCharacter.position - position)
		var diffToTarget = realDifToTarget.normalized();
		var lerpFactor = $Timer.time_left / $Timer.wait_time;
		speed = (startSpeed/lerpFactor) * 12
	
		if realDifToTarget.length() < 3 :
			#print("high speed")
			oldDiffToTarget = diffToTarget;
			chilling = true;
		else :
			newDir = lerp(direction, diffToTarget, lerpFactor*0.6);
		
	
	position += newDir * delta * speed;
