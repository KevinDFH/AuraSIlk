extends StateTransitionBase
class_name BattleVictory

var resolution := "stabilize"  # "stabilize" | "kill"
var rewards := {}

func enter(msg := {}) -> void: #Esto debe venir del enemigo para saber si fue matado o estabilizado
	print("🏆 [BattleVictory] Batalla ganada")

	resolution = msg.get("resolution", "stabilize")
	rewards = msg.get("rewards", {})

	transition_time = 1.0
	anim_direction = "down"

	match resolution:
		"stabilize":
			anim_action = "stabilize"
			print("🌱 Resolución: estabilizar")
		"kill":
			anim_action = "kill"
			print("🔥 Resolución: eliminar")
		_:
			anim_action = ""

	super.enter(msg)

func transition_finished() -> void:
	print("📦 [BattleVictory] Aplicando recompensas")

	_aplicar_recompensas()
	_abrir_menu_recompensas()

func _aplicar_recompensas() -> void:
	if rewards.has("money"):
		player.dinero += rewards.money

	if rewards.has("karma"):
		player.karma += rewards.karma

	print("💰 Dinero:", rewards.get("money", 0))
	print("⚖️ Karma:", rewards.get("karma", 0))

func _abrir_menu_recompensas() -> void:
	print("Recompensas obtenidas")
	print("Items:", rewards.get("items", []))

	GameManager.finalizar_batalla("victory_" + resolution)
