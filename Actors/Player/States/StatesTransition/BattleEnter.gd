extends StateTransitionBase
class_name BattleEnter

func enter(_msg := {}) -> void:
	print("✨ [BattleEnter] Iniciando transición a combate")

	# Configuración básica de la transición
	transition_time = 1.0
	anim_action = ""        # Más adelante: "transform"
	anim_direction = "down"

	# Llamamos al comportamiento base (bloqueo, timer, etc.)
	super.enter(_msg)

func transition_finished() -> void:
	print("⚔️ [BattleEnter] Transición finalizada → entrando a BattleIdle")
	# Cambiar al estado de combate
	state_machine.change_state($"../BattleIdle")
