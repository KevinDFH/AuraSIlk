extends StateTransitionBase
class_name BattleDead

@export var death_time := 1.5

func enter(msg := {}) -> void:
	print("☠️ [BattleDead] El jugador ha muerto")

	transition_time = death_time
	anim_action = "death"   # luego existirá
	anim_direction = "down"

	super.enter(msg)

func transition_finished() -> void:
	print("[BattleDead] Derrota confirmada")
	GameManager.terminar_batalla("player_dead")
	var controlador := get_tree().get_first_node_in_group("battle_controller")
	if controlador and controlador.has_method("_on_dead_transition_finished"):
		controlador._on_dead_transition_finished()
