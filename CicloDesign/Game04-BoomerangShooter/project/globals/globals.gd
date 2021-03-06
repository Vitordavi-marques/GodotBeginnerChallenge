extends Node

enum ENTITY_TYPES {
	NULL = 0,
	ENTITY_PLAYER = 1,
	ENTITY_BOOMERANG = 2,
	ENTITY_ENEMY_FOLLOWER = 3}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func get_game():
	return get_node("/root/Game")

func get_screen_size() -> Vector2:
	return get_viewport().get_visible_rect().size

func get_screen_center() -> Vector2:
	return get_screen_size() / 2

func rand_sign() -> int:
	return int(pow(-1,randi()%2))
