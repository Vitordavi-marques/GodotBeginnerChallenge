extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal started_jumping()
signal touched_ground_while_idle()
signal touched_ground_while_moving()

signal boost_available()
signal boost_unavailable()

signal pressed_boost()
signal started_boost()
signal missed_boost()

func physics_process(delta):
	.physics_process(delta)
	if actor.body.is_grounded():
		if actor.input_controller.move_direction != 0:
			emit_signal("touched_ground_while_moving")
		else:
			emit_signal("touched_ground_while_idle")

func _on_BoostTrigger_grouped_area_entered(area):
	if fsm.current_state == self:
		emit_signal("boost_available")

func _on_BoostTrigger_grouped_area_exited(area):
	if fsm.current_state == self:
		emit_signal("boost_unavailable")

func _on_jump_just_pressed():
	if fsm.current_state == self and actor.entity_mover.can_jump() and actor.jump_cooldown_timer.is_stopped():
		emit_signal("started_jumping")

func _on_boost_just_pressed():
	if fsm.current_state == self and actor.boost_cooldown_timer.is_stopped():
		emit_signal("pressed_boost")
		if actor.boost_trigger.can_boost:
			emit_signal("started_boost")
		else:
			emit_signal("missed_boost")
