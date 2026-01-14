extends CharacterBody2D
class_name Player

# ===============================
# 🔹 NODOS HIJOS
# ===============================
@onready var anim: AnimatedSprite2D =$AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

@onready var state_world_idle = $StateMachine/WorldIdle
@onready var state_world_inventory = $StateMachine/WorldInventory

# ===============================
# 🔹 ATRIBUTOS DEL JUGADOR
# ===============================
var vida: int = 20
var max_vida: int = 20
var karma: int = 0
var dinero: int = 0
var inventario: Array = []

# ===============================
# 🔹 SISTEMA DE SKINS
# ===============================
var skins = {
	"world" : preload("res://Actors/Player/Sprites/world_frames.tres"),
	"battle": preload("res://Actors/Player/Sprites/battle_frames.tres")
}
var current_skin := "world"

# ===============================
# 🔹 CICLO DE VIDA
# ===============================
func _ready():
	GameManager.player = self
	GameManager.connect("battle_started", Callable(self, "_on_battle_started"))
	GameManager.connect("battle_ended", Callable(self, "_on_battle_ended"))

	print("✅ Player listo en modo WorldIdle.")
	state_machine.change_state(state_world_idle)

# ===============================
# 🔹 EVENTOS GLOBALES
# ===============================
func _on_battle_started(boss):
	set_skin("battle")
	print("⚔️ El jugador entra en modo batalla contra", boss.name)
	state_machine.change_state($StateMachine/BattleEnter)

func _on_battle_ended(result):
	set_skin("world")
	print("🌿 El jugador vuelve al modo mundo.")
	state_machine.change_state(state_world_idle)

# ===============================
# 🔹 SKINS
# ===============================
func set_skin(name: String) -> void:
	if skins.has(name):
		current_skin = name
		anim.sprite_frames = skins[name]
		print("🎨 Skin cambiado a:", name)
	else:
		push_warning("⚠️ Skin no encontrado: " + name)

# ===============================
# 🔹 ANIMACIONES (para estados)
# ===============================
func play_anim(action: String, direction: String) -> void:
	# Ejemplo: play_anim("walk", "up") → animación "walk_up"
	var anim_name = "%s_%s" % [action, direction]
	if anim.animation != anim_name:
		# anim.play(anim_name)
		print("🎬 (Simulando animación):", anim_name)  # ← temporal hasta tener sprites reales

# ===============================
# 🔹 INVULNERABILIDAD
# ===============================
func set_invulnerable(valor: bool) -> void:
	pass
