extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func enter(info: Dictionary = {}):
	if info.has("is_jumping") and info["is_jumping"]:
		fsm.change_state("air/jump", info)
	else:
		fsm.change_state("air/fall")
