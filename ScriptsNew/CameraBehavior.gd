extends Camera3D

func _ready():
	var singletons = Singletons;
	singletons.CameraObject = self;
