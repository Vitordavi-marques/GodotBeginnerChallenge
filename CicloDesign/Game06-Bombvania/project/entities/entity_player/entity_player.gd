extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal collected_heart()
signal collected_money(amount)
signal took_damage(damage)
signal died()

onready var kick_timer = $Timers/KickTimer
onready var health = $Stats/Health
onready var bomb_origin = $Body/bomb_origin
onready var visited_points = $Body/bomb_origin/visited_points
onready var bomb_raycasts = $Body/Triggers/Raycasts/BombRaycast

var bombs = []
var world_bombs_manager

func get_previous_point() -> Vector2:
	if visited_points.points.size() > 0:
		return visited_points.points[0]
	return Vector2.ZERO

func _on_DamageHurtbox_took_damage(damage):
	emit_signal("took_damage", damage)

func _on_CollectibleTrigger_grouped_area_entered(area):
	match area.entity.collectible_type:
		Globals.COLLECTIBLE_TYPES.HEART:
			emit_signal("collected_heart")
		Globals.COLLECTIBLE_TYPES.MONEY_COIN:
			emit_signal("collected_money", Globals.MONEY_COIN)
		Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND:
			emit_signal("collected_money", Globals.MONEY_DIAMOND)
