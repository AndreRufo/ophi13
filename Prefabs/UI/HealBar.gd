extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	var HealTimer = Singletons.PlayerCharacter.get_node("HealTimer");
	max_value = HealTimer.wait_time;
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Singletons.PlayerCharacter.isDancing:
		get_parent().visible = true
		var HealTimer : Timer = Singletons.PlayerCharacter.get_node("HealTimer");
		value = max_value - HealTimer.time_left;
	else:
		get_parent().visible = false
