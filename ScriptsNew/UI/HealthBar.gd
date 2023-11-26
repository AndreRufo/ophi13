extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = Singletons.PlayerCharacter.MaxHealth
	Singletons.player_damaged.connect(_on_player_damaged);
	Singletons.player_healed.connect(_on_player_healed);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_damaged(hp_after_damage):
	value = hp_after_damage;
	
func _on_player_healed(hp_after_heal):
	value = hp_after_heal;
