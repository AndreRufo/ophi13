extends BaseEnemy

@export var SniperPositions : Array[Vector3] = [];
var current_position_index : int = 0;

@export var ShotChargeRate : float = 0.5;
var shot_cooldown_timer : Timer;
var can_shoot : bool = true;
@export var ShotCooldown : float = 5;
var shot_charge : float = 0;
var hud_bullseye : BullseyeBehavior;

@export var RotationSpeed : float = 0.85;
var is_jumping : bool = false;
@export var TopHeightOfJump : float = 10;
@export var JumpMovementSpeed : float = 1.5;
var original_dist_to_target : float = 0;
@export_flags_3d_physics var SniperCollisionMask;
@export var selects_random_position = false;

## Sagittarius will lock onto the player automatically and then begin charging a bullet
## Fires when fully charged
func _ready():
	super();
	hud_bullseye = Singletons.Hud.spawn_bullseye();
	shot_cooldown_timer = Timer.new();
	shot_cooldown_timer.one_shot = true;
	shot_cooldown_timer.connect("timeout", on_cooldown_timer_timeout);
	add_child(shot_cooldown_timer);
	
func _physics_process(delta):
	var new_forward = (Singletons.PlayerCharacter.position - position).normalized();
	new_forward.y = 0;
	transform.basis.z = new_forward;
		
	if(can_shoot && !is_jumping):
		shot_charge = min(shot_charge + delta * ShotChargeRate, 1);
		hud_bullseye.lock_progress = shot_charge;
		if(shot_charge == 1):
			$BulletSpawnersContainer/BulletSpawner.ShootBullet(new_forward);
			shot_charge = 0;
			can_shoot = false;
			hud_bullseye.visible = false;
			hud_bullseye.lock_progress = shot_charge;
			shot_cooldown_timer.start(ShotCooldown);
			
	elif(is_jumping):
		jump();

func jump():
	if(position == SniperPositions[current_position_index]):
		end_jump();
	
	var cur_hor_pos = position;
	cur_hor_pos.y = 0;
	var tar_hor_pos = SniperPositions[current_position_index];
	tar_hor_pos.y = 0;
	var dist_to_tar = cur_hor_pos.distance_to(tar_hor_pos);
	position = lerp(position, SniperPositions[current_position_index], get_physics_process_delta_time() * JumpMovementSpeed);
	if(original_dist_to_target > 0):
		position.y = 1.5 + (TopHeightOfJump * dist_to_tar/original_dist_to_target);
	if(dist_to_tar < 0.1):
		end_jump();

func end_jump():
	position = SniperPositions[current_position_index];
	is_jumping = false;
	can_shoot = true;
	hud_bullseye.visible = true;

func on_cooldown_timer_timeout():
	is_jumping = true;
	get_next_position();
	
	#Get current distance to new position
	var cur_hor_pos = position;
	cur_hor_pos.y = 0;
	var tar_hor_pos = SniperPositions[current_position_index];
	tar_hor_pos.y = 0;
	original_dist_to_target = cur_hor_pos.distance_to(tar_hor_pos);

#Pick the best position where the player is visible
#If no such position, pick random
func get_next_position():
	if(!selects_random_position):
		#Get Viable Firing Position
		var idx = 0;
		var visible_player_idx : int = -1;
		var space_state = get_world_3d().direct_space_state;

		for p in SniperPositions:
			var ray = PhysicsRayQueryParameters3D.create(p, Singletons.PlayerCharacter.position);
			ray.exclude = [self];
			var result = space_state.intersect_ray(ray);
			if(result && result.collider == Singletons.PlayerCharacter):
				visible_player_idx = idx;
				break;
			idx += 1;
		
		if(visible_player_idx != -1):
			print("Found viable position");
			current_position_index = visible_player_idx;
		else:
			print("No viable position");
			get_random_position();
	else:
		get_random_position();
func get_random_position():
	#Get random position
	current_position_index = randi() % (SniperPositions.size() - 1);
	var next_pos = SniperPositions[current_position_index];
	SniperPositions.erase(next_pos);
	SniperPositions.push_back(next_pos);
