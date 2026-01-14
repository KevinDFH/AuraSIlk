extends StateBase
class_name PlayerStateBase

# ===============================
# VARIABLES BÁSICAS
# ===============================
@onready var interactor: RayCast2D = $"../../Interactor"

var inventario
var velocidad: float = 0.0
var direccion_actual  # Por defecto mirando abajo

# Referencia al jugador (Player)
var player: Player:
	set(value):
		controlled_node = value
	get:
		return controlled_node


# ===============================
# MÉTODOS DE MOVIMIENTO
# ===============================
func obtener_direccion() -> Vector2:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if dir != Vector2.ZERO:
		direccion_actual = dir
	return dir


# ===============================
# INVENTARIO
# ===============================
func abrir_inventario(inventario) -> void:
	state_machine.push_state(inventario)


# ===============================
# TOGGLES DE COLISIONES Y ÁREAS
# ===============================
func _toggle_world_collisions(active: bool) -> void:
	if player and player.has_node("CollisionWorld"):
		player.get_node("CollisionWorld").disabled = not active

func _toggle_battle_collisions(active: bool) -> void:
	if player and player.has_node("CollisionBattle"):
		player.get_node("CollisionBattle").disabled = not active

func _toggle_dashbox(active: bool) -> void:
	if player and player.has_node("DashBox"):
		var dashbox = player.get_node("DashBox")
		dashbox.visible = active
		dashbox.monitoring = active

func _toggle_interactor(active: bool) -> void:
	if interactor:
		interactor.enabled = active
