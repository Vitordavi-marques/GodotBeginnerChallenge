extends GTState

onready var FALL = $"../Fall"
onready var DEAD = $"../Dead"

func enter(_info = null):
	actor.jump()

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.velocity.y < 0:
		fsm.change_state(FALL)

func _on_jump_just_released():
	if fsm.current_state == self and actor.can_jump:
		actor.entity_mover.damp_jump()

func _on_Player_died():
	if fsm.current_state == self:
		fsm.change_state(DEAD)
