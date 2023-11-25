extends BaseEnemy

@export var BulletScene : PackedScene;
@export var BulletMaterial : StandardMaterial3D;
@export var DelayBetweenLocationGeneration : float = 2;
@export var MaxDistanceFromPlayer = 30;
var location_generation_timer : Timer;
var target_location : Vector3;

@export var BulletsInnerRing :int = 10;
@export var BulletsMedRing : int = 20;
@export var BulletsOuterRing : int = 60;

func _ready():
	super();
	location_generation_timer = Timer.new();
	location_generation_timer.one_shot = true;
	location_generation_timer.connect("timeout", on_location_generation_timer_timeout);
	add_child(location_generation_timer);
	
	get_new_target_location();
	location_generation_timer.start(DelayBetweenLocationGeneration);
	
	var base_direction = Vector3(1, 0, 1);
	var idx = 0;
	for i in BulletsInnerRing:
		var x = 10 * cos(deg_to_rad((360/BulletsInnerRing) * idx));
		var z = 10 * sin(deg_to_rad((360/BulletsInnerRing) * idx));
		
		var new_bullet : Node3D = BulletScene.instantiate();
		new_bullet.is_player_bullet = false;
		new_bullet.SetColor(BulletMaterial);
		new_bullet.position = Vector3(x, 0, z);
		$BulletSpawnersContainer/InnerRing.add_child(new_bullet);
		idx += 1;
	idx = 0;
	for i in BulletsMedRing:
		var x = 20 * cos(deg_to_rad((360/BulletsMedRing) * idx));
		var z = 20 * sin(deg_to_rad((360/BulletsMedRing) * idx));
		var new_bullet : Node3D = BulletScene.instantiate();
		new_bullet.is_player_bullet = false;
		new_bullet.SetColor(BulletMaterial);
		new_bullet.position = Vector3(x, 0, z);
		$BulletSpawnersContainer/MedRing.add_child(new_bullet);
		idx += 1;
	idx = 0;
	for i in BulletsOuterRing:
		var x = 40 * cos(deg_to_rad((360/BulletsOuterRing) * idx));
		var z = 40 * sin(deg_to_rad((360/BulletsOuterRing) * idx));
		var new_bullet : Node3D = BulletScene.instantiate();
		new_bullet.is_player_bullet = false;
		new_bullet.SetColor(BulletMaterial);
		
		new_bullet.position = Vector3(x, 0, z);
		$BulletSpawnersContainer/OuterRing.add_child(new_bullet);
		idx += 1;

func _physics_process(delta):
	velocity = (target_location - position).normalized() * Speed;
	move_and_slide();
	
	$BulletSpawnersContainer/InnerRing.rotation += Vector3(0, delta * 0.5, 0);
	$BulletSpawnersContainer/MedRing.rotation += Vector3(0, delta * -0.5, 0);
	$BulletSpawnersContainer/OuterRing.rotation += Vector3(0, delta * 0.5, 0);

func on_location_generation_timer_timeout():
	get_new_target_location();
	location_generation_timer.start(DelayBetweenLocationGeneration);

func get_new_target_location():
	var direction_vec = Vector3(randf_range(-1.0, 1.0), 0, randf_range(-1.0, 1.0)) * randi_range(-MaxDistanceFromPlayer, MaxDistanceFromPlayer);
	target_location = Singletons.PlayerCharacter.position + direction_vec;
