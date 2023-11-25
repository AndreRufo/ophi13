extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = Singletons.PlayerCharacter.MaxHealth
	Singletons.player_damaged.connect(_on_player_damaged);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_damaged(hp_after_damage):
	value = hp_after_damage;
