extends Node
class_name Game_Manager

# ====================================================
# 🔹 SEÑALES GLOBALES DEL JUEGO
# ====================================================
signal battle_started(boss)
signal battle_ended(result)
signal game_paused()
signal game_resumed()
signal world_entered()

enum GameMode { WORLD, BATTLE }
var game_mode := GameMode.WORLD

# ====================================================
# 🔹 VARIABLES GLOBALES / ESTADO DEL JUEGO
# ====================================================
var player: Player = null                # Referencia global al jugador actual
var boss_actual: Node = null             # Referencia al jefe activo (si hay batalla)

var karma: int = 0
var dinero: int = 0
var inventario: Array = []
var progreso_historia: Dictionary = {}

# ====================================================
# 🔹 FUNCIONES PRINCIPALES DEL JUEGO
# ====================================================

# --- Inicia la batalla contra un jefe ---
func iniciar_batalla(boss: Node) -> void:
	if boss == null:
		push_warning("Intento de iniciar batalla sin jefe válido.")
		return
	
	boss_actual = boss
	print("🎮 Iniciando batalla contra:", boss.name)
	game_mode = GameMode.BATTLE
	emit_signal("battle_started", boss)

# --- Termina una batalla ---
func finalizar_batalla(resultado: String = "none") -> void:
	print("🏁 Batalla finalizada con resultado:", resultado)
	game_mode = GameMode.WORLD
	emit_signal("battle_ended", resultado)
	boss_actual = null
	

# --- Cambiar al modo exploración (world) ---
func entrar_al_mundo() -> void:
	emit_signal("world_entered")

# --- Control global de pausa ---
func pausar_juego() -> void:
	get_tree().paused = true
	emit_signal("game_paused")

func reanudar_juego() -> void:
	get_tree().paused = false
	emit_signal("game_resumed")

# ====================================================
# 🔹 GESTIÓN GLOBAL DE KARMA, DINERO, INVENTARIO
# ====================================================
func modificar_karma(valor: int) -> void:
	karma += valor
	print("🌀 Karma actual:", karma)

func agregar_item(nombre: String) -> void:
	inventario.append(nombre)
	print("➕ Añadido al inventario:", nombre)

func gastar_dinero(valor: int) -> void:
	dinero = max(0, dinero - valor)
	print("💰 Dinero restante:", dinero)

func ganar_dinero(valor: int) -> void:
	dinero += valor
	print("💵 Dinero total:", dinero)
