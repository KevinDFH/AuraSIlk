extends PlayerStateBase
class_name StateTransitionBase

@export var transition_time: float = 1.0
@export var anim_action: String = ""     # ej: "transform", "death"
@export var anim_direction: String = "down"

var _finished := false

func enter(_msg := {}) -> void:
	_finished = false
	
	if player:
		player.velocity = Vector2.ZERO
		player.set_invulnerable(true)

	# Desactivar TODO
	_toggle_world_collisions(false)
	_toggle_battle_collisions(false)
	_toggle_interactor(false)
	_toggle_dashbox(false)

	if anim_action != "":
		player.play_anim(anim_action, anim_direction)

	_run_timer()

func handle_input(event: InputEvent) -> void:
	# No input durante transición
	pass

func update(delta: float) -> void:
	# No movimiento
	pass

func exit() -> void:
	_finished = true
	if player:
		player.set_invulnerable(false)

func _run_timer() -> void:
	if transition_time <= 0:
		_on_transition_finished()
		return

	await get_tree().create_timer(transition_time).timeout
	_on_transition_finished()

func transition_finished() -> void:
	pass


func _on_transition_finished() -> void:
	if _finished:
		return
	_finished = true
	transition_finished()
