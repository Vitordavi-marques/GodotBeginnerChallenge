extends GTDeviceController

var move_direction : int

func _physics_process(delta):
	move_direction = int(get_input("act_move_right", PRESSED))-int(get_input("act_move_left", PRESSED))
