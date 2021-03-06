extends "res://entities/__entity_platformer_player/states/__entity_platformer_player_movement_state.gd"

signal started_jumping()
signal started_falling()

func physics_process(delta):
	.physics_process(delta)
	if actor.entity_mover.gravity_mask == 1.0:
		if actor.entity_mover.velocity.y > 0: emit_signal("started_falling")
	elif actor.entity_mover.gravity_mask == -1.0:
		if actor.entity_mover.velocity.y < 0 : emit_signal("started_falling")

func damp_jump():
	if fsm.current_state == self and actor.can_small_jump:
		actor.entity_mover.damp_jump()

func _on_jump_just_pressed():
	if fsm.current_state == self and actor.entity_mover.can_jump() and actor.jump_cooldown_timer.is_stopped():
		emit_signal("started_jumping")
