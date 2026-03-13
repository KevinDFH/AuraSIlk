extends StateTransitionBase
class_name BattleEnter

func enter(_msg := {}) -> void:
	print("[BattleEnter] Iniciando transicion a combate")

	transition_time = 1.0
	anim_action = ""
	anim_direction = "down"

	if player:
		player.set_skin("battle")

	super.enter(_msg)

func transition_finished() -> void:
	print("[BattleEnter] Transicion finalizada")

	var controlador := get_tree().get_first_node_in_group("world_controller")
	if controlador and controlador.has_method("_on_battle_transition_finished"):
		controlador._on_battle_transition_finished()
