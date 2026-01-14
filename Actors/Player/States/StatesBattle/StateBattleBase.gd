extends PlayerStateBase
class_name StateBattleBase
@export var dash_cooldown_max: float = 1.0
var dash_cooldown_timer: float = 0.0
# ==============================
#   VARIABLES DE MOVIMIENTO
# ==============================
@export var velocidad_base: float = 300.0

# ==============================
#   INPUTS (ACCIONES DE COMBATE)
# ==============================
func handle_input(event: InputEvent) -> void:
	# Hereda la gestión de inventario
	if event.is_action_pressed("ui_inventory"):
		pass

# ==============================
#   UPDATE
# ==============================
func update(delta: float) -> void:
	if not player:
		print("No se detecta jugador")
		return
		#Dash
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	var direccion := obtener_direccion()
	velocidad = velocidad_base
	player.velocity = direccion * velocidad
	player.move_and_slide()
	
# ==============================
#   PHYSICS UPDATE
# ==============================
func physics_update(_delta: float) -> void:
	pass	
#	DASH
func can_dash() -> bool:
	return dash_cooldown_timer <= 0

func start_dash_cooldown() -> void:
	dash_cooldown_timer = dash_cooldown_max
