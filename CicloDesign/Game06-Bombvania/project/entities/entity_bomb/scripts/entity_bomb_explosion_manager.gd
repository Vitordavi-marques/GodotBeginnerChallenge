extends Node

export (NodePath) var _entity_path
export (NodePath) var _body_path

const JOB_SPAWN_ENTITY_EXPLOSION = "job_spawn_entity_explosion"
const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

onready var spawner = $Spawner

var entity
var body

func _ready():
	entity = get_node(_entity_path)
	body = get_node(_body_path)
	assert(entity != null, "Error initializing EntityBombExplosionManager: 'entity' property is null")
	assert(body != null, "Error initializing EntityBombExplosionManager: 'body' property is null")

func explode():
	body.global_position = Globals.snap_to_tile(body.global_position) + Globals.TILE_SIZE*Vector2(0.5, 0.5)
	spawner.spawn_with_info({"global_position": body.global_position})
	
	if not entity.is_diamond:
		
		for dir in DIRECTIONS:
			for power in range(1, entity.power+1):
				var new_pos = body.global_position + power*dir*Globals.TILE_SIZE
				if entity.tilemap.is_wall_tile_in_pos(new_pos):
					break
				var info = {
					"global_position": new_pos}
				#JobQueue.schedule(JOB_SPAWN_ENTITY_EXPLOSION, spawner, "spawn_with_info", [info])
				spawner.spawn_with_info(info)
				if not entity.is_spike:
					if entity.tilemap.is_destructible_tile_in_pos(new_pos):
						break
	else:
		
		pass
