extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal started_jumping()
signal started_boost()
signal touched_ground_while_idle()
signal touched_ground_while_moving()

func physics_process(delta):
	.physics_process(delta)
	if actor.body.is_grounded():
		if actor.input_controller.move_direction != 0:
			emit_signal("touched_ground_while_moving")
		else:
			emit_signal("touched_ground_while_idle")

func _on_jump_just_pressed():
	if fsm.current_state == self and actor.entity_mover.can_jump() and actor.jump_cooldown_timer.is_stopped():
		if actor.trampoline_trigger.can_trampoline:
			emit_signal("started_boost")
		else:
			emit_signal("started_jumping")
