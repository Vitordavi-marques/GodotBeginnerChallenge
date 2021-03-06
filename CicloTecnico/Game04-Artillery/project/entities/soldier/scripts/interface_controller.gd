extends InputController
class_name InterfaceController, "res://libs/input_controller/icons/programmed-controller.svg"

var desired_angle
var desired_charge
var desired_weapon
var desired_direction
var current_angle
var current_charge

var previous_charge_hold : bool = false

func get_input(info = null):
	if not info or not is_active:
		return
	desired_angle = info["desired_angle"]
	desired_charge = info["desired_charge"]
	desired_weapon = info["desired_weapon"]
	desired_direction = info["desired_direction"]
	current_angle = info["current_angle"]
	current_charge = info["current_charge"]
	
	aim_direction = -sign(desired_angle-current_angle)
	charge_hold = (current_charge < desired_charge)
	charge_press = (not previous_charge_hold and charge_hold)
	charge_released = (previous_charge_hold and not charge_hold)
	weapon_selected = desired_weapon
	move_direction = Vector2(sign(desired_direction), 0)
	if move_direction.x != 0:
		last_move_direction = move_direction.x
	
	previous_charge_hold = charge_hold
