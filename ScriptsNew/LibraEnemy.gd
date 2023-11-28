extends BaseEnemy

@export var BulletScene : PackedScene;
@export var BulletMaterial : StandardMaterial3D;
@export var BulletsToGenerate = 15;

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

func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized();
	
	if(position.distance_to(Singletons.PlayerCharacter.position) > 20):
		velocity = (Singletons.PlayerCharacter.position - position).normalized() * Speed;
	else:
		velocity += -direction * Speed * delta;
	move_and_slide();
	
func on_location_generation_timer_timeout():
	get_new_target_location();
	location_generation_timer.start(DelayBetweenLocationGeneration);
	
func get_new_target_location():
	var direction_vec = Vector3(randf_range(-1.0, 1.0), 0, randf_range(-1.0, 1.0)) * randi_range(-MaxDistanceFromPlayer, MaxDistanceFromPlayer);
	target_location = Singletons.PlayerCharacter.position + direction_vec;

func on_take_damage():
	super()
	var idx = 0;
	for i in BulletsToGenerate:
		var x = 2 * cos(deg_to_rad((360/BulletsToGenerate) * idx));
		var z = 2 * sin(deg_to_rad((360/BulletsToGenerate) * idx));
		var new_bullet : Node3D = BulletScene.instantiate();
		new_bullet.is_player_bullet = false;
		new_bullet.SetColor(BulletMaterial);
		new_bullet.direction = Vector3(x, 0, z).normalized();
		new_bullet.position = position + Vector3(x, 0, z);
		get_tree().root.add_child(new_bullet);
		idx += 1;
