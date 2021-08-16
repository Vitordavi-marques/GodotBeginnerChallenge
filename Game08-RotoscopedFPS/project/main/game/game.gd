extends Spatial

onready var world = $viewport_container/viewport/World

#func _ready():
#	var qodot_fgd = load("res://addons/qodot/game_definitions/fgd/qodot_fgd.tres")
#	qodot_fgd.set_export_file(true)
#	get_node("World/Level/root/map").verify_and_build()

func _ready():
	randomize()

func add_entity(entity):
	world.level.root.map.add_child(entity)
