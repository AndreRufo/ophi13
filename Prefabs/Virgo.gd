extends BaseEnemy

@export var DelayBetweenLocationGeneration : float = 2;
@export var MaxDistanceFromPlayer = 30;
var location_generation_timer : Timer;
var target_location : Vector3;

func _ready():
	super();
	location_generation_timer = Timer.new();
	location_generation_timer.one_shot = true;
	location_generation_timer.connect("timeout", on_location_generation_timer_timeout);
	add_child(location_generation_timer);
	
	get_new_target_location();
	location_generation_timer.start(DelayBetweenLocationGeneration);
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.4);
	
func on_location_generation_timer_timeout():
	get_new_target_location();
	location_generation_timer.start(DelayBetweenLocationGeneration);
	
func get_new_target_location():
	var direction_vec = Vector3(randf_range(-1.0, 1.0), 0, randf_range(-1.0, 1.0)) * randi_range(-MaxDistanceFromPlayer, MaxDistanceFromPlayer);
	target_location = Singletons.PlayerCharacter.position + direction_vec;

func _physics_process(delta):
	velocity = (target_location - position).normalized() * Speed;
	move_and_slide();
	
	$BulletSpawnersContainer.rotation += Vector3(0, delta * 1, 0);
