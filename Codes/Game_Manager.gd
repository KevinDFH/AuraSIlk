extends Node
class_name Game_Manager

# ====================================================
# 🔹 SEÑALES GLOBALES DEL JUEGO
# ====================================================
signal battle_started(boss)
signal battle_ended(result)
signal battle_requested()
signal battle_finished(result)
signal game_paused()
signal game_resumed()
signal world_entered()

enum GameMode { WORLD, BATTLE }
var game_mode := GameMode.WORLD

# ====================================================
# 🔹 VARIABLES GLOBALES / ESTADO DEL JUEGO
# ====================================================
var player: Player = null
var boss_actual: Node = null

# Fuente persistente de los datos del jugador entre escenas.
var player_data := {
	"vida": 20,
	"max_vida": 20,
	"karma": 0,
	"dinero": 0,
	"inventario": []
}

var progreso_historia: Dictionary = {}
var pending_battle: Dictionary = {}
var return_scene_path: String = ""
var return_position: Vector2 = Vector2.ZERO

# ====================================================
# 🔹 FUNCIONES PRINCIPALES DEL JUEGO
# ====================================================
func iniciar_batalla(boss: Node) -> void:
	if boss == null:
		push_warning("Intento de iniciar batalla sin jefe válido.")
		return
	
	boss_actual = boss
	print("🎮 Iniciando batalla contra:", boss.name)
	game_mode = GameMode.BATTLE
	emit_signal("battle_started", boss)

func solicitar_batalla(datos_batalla: Dictionary) -> void:
	pending_battle = datos_batalla.duplicate(true)
	emit_signal("battle_requested")


func terminar_batalla(resultado: String = "none") -> void:
	emit_signal("battle_finished", resultado)
	pending_battle.clear()
	
func entrar_al_mundo() -> void:
	emit_signal("world_entered")

func pausar_juego() -> void:
	get_tree().paused = true
	emit_signal("game_paused")

func reanudar_juego() -> void:
	get_tree().paused = false
	emit_signal("game_resumed")

# ====================================================
# 🔹 SINCRONIZACIÓN DEL JUGADOR
# ====================================================
func save_player_stats(vida: int, max_vida: int, karma: int, dinero: int, inventario: Array) -> void:
	player_data["vida"] = vida
	player_data["max_vida"] = max_vida
	player_data["karma"] = karma
	player_data["dinero"] = dinero
	player_data["inventario"] = inventario.duplicate(true)

func get_player_stats() -> Dictionary:
	return {
		"vida": player_data["vida"],
		"max_vida": player_data["max_vida"],
		"karma": player_data["karma"],
		"dinero": player_data["dinero"],
		"inventario": player_data["inventario"].duplicate(true)
	}
