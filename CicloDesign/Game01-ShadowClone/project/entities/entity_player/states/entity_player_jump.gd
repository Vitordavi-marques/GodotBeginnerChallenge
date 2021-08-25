extends "res://entities/entity_player/states/entity_player_movement_state.gd"

signal started_falling()

func physics_process(delta):
	.physics_process(delta)
	if actor.entity_mover.velocity.y > 0:
		emit_signal("started_falling")

func damp_jump():
	if fsm.current_state == self:
		actor.entity_mover.damp_jump()
