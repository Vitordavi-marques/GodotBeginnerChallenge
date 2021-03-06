extends Entity

signal health_updated(current)
signal died()

export (float, 0.0, 1.0) var mouse_sensitivity = 0.15
export (bool) var can_jump = true
export (bool) var allow_vertical_looking = true

onready var weapon = $Weapon
onready var entity_mover = $EntityMover
onready var health = $Health
onready var input_controller = $PlayerController
onready var camera = $Head/bobbing/tilt/Camera
onready var muzzle_flash = $Head/bobbing/tilt/Camera/muzzle_flash

func _ready():
	weapon.connect("weapon_fired", muzzle_flash, "start_flash")
	weapon.connect("weapon_reloading", muzzle_flash, "stop_flash")

func _input(event):
	if event is InputEventMouseMotion and health.is_alive:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		if allow_vertical_looking:
			camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
			camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -89, 89)

func jump():
	entity_mover.turn_off_snap()
	entity_mover.jump()

func shoot():
	weapon.shoot(-transform.basis.z, -camera.global_transform.basis.z)

func get_info():
	return {
		"position": global_transform.origin,
		"rotation": rotation,
		"type": Globals.ENTITIES.PLAYER}

func _on_Health_health_updated(current):
	emit_signal("health_updated", current)
	
func _on_Health_died(current):
	weapon.sway.is_active = false
	emit_signal("died")
