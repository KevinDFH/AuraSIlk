extends Node2D

const PLAYER_SCENE := preload("res://Actors/Player/Player.tscn")

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var bullet_template: Area2D = $Area2DBullet
@onready var corner_right_up: Marker2D = $CornerRightUp
@onready var corner_left_bottom: Marker2D = $CornerLeftBottom
# TEMP: barra de vida del panel derecho usada como debug rapido en batalla.
@onready var player_hp_bar: ProgressBar = $CanvasLayer/BattleUI/HBoxContainer/RightPanel/VBoxContainer/PlayerPanel/VBoxContainer/Vida

var arena_layer: Node2D = null
var bullet_layer: Node2D = null
var jugador: CharacterBody2D = null
var arena_margin: float = 0.0
# TEMP: ritmo basico del prototipo bullet hell.
var bullet_spawn_interval: float = 0.2
# TEMP: acumulador del spawner temporal.
var bullet_spawn_timer: float = 0.0

func _ready() -> void:
	add_to_group("battle_controller")
	GameManager.game_mode = GameManager.GameMode.BATTLE
	_preparar_arena_layer()
	_preparar_template_bala()
	_crear_jugador_batalla()

func _physics_process(delta: float) -> void:
	if not is_instance_valid(jugador):
		return
	var arena_rect: Rect2 = get_arena_rect()
	var player_rect: Rect2 = arena_rect.grow_individual(-arena_margin, -arena_margin, -arena_margin, -arena_margin)

	var clamped_position := jugador.global_position
	clamped_position.x = clamp(clamped_position.x, player_rect.position.x, player_rect.end.x)
	clamped_position.y = clamp(clamped_position.y, player_rect.position.y, player_rect.end.y)
	jugador.global_position = clamped_position

	# TEMP: patron basico para probar spawner y limpieza de balas.
	_actualizar_spawner_temporal(delta)
	# TEMP: sincroniza la barra Vida del panel con la vida real del jugador.
	_actualizar_barra_vida_temporal()

func _preparar_arena_layer() -> void:
	arena_layer = canvas_layer.get_node_or_null("ArenaLayer") as Node2D
	if arena_layer == null:
		arena_layer = Node2D.new()
		arena_layer.name = "ArenaLayer"
		canvas_layer.add_child(arena_layer)

	bullet_layer = arena_layer.get_node_or_null("BulletLayer") as Node2D
	if bullet_layer == null:
		bullet_layer = Node2D.new()
		bullet_layer.name = "BulletLayer"
		arena_layer.add_child(bullet_layer)

# TEMP: el Area2DBullet de la escena se usa solo como plantilla visual/collision para duplicar balas.
func _preparar_template_bala() -> void:
	bullet_template.visible = false
	bullet_template.process_mode = Node.PROCESS_MODE_DISABLED

func _crear_jugador_batalla() -> void:
	jugador = PLAYER_SCENE.instantiate()
	arena_layer.add_child(jugador)
	jugador.scale=Vector2(0.5,0.5)
	jugador.global_position = player_spawn.global_position
	jugador.load_stats()
	jugador.set_skin("battle")
	jugador.state_machine.change_state(jugador.get_node("StateMachine/BattleIdle"))
	arena_margin = _obtener_margen_arena(jugador)

func get_arena_rect() -> Rect2:
	var min_x: float = min(corner_left_bottom.global_position.x, corner_right_up.global_position.x)
	var max_x: float = max(corner_left_bottom.global_position.x, corner_right_up.global_position.x)
	var min_y: float = min(corner_right_up.global_position.y, corner_left_bottom.global_position.y)
	var max_y: float = max(corner_right_up.global_position.y, corner_left_bottom.global_position.y)

	return Rect2(
		Vector2(min_x, min_y),
		Vector2(max_x - min_x, max_y - min_y)
	)

# TEMP: actualiza la barra Vida mientras no exista UI final de combate.
func _actualizar_barra_vida_temporal() -> void:
	if not is_instance_valid(jugador):
		return

	player_hp_bar.max_value = max(jugador.max_vida, 1)
	player_hp_bar.value = jugador.vida

# TEMP: spawner provisional con una rafaga simple hacia abajo.
func _actualizar_spawner_temporal(delta: float) -> void:
	bullet_spawn_timer += delta
	if bullet_spawn_timer < bullet_spawn_interval:
		return

	bullet_spawn_timer = 0.0
	_crear_bala_temporal(Vector2.DOWN.rotated(deg_to_rad(-16.0)) * 420.0)
	_crear_bala_temporal(Vector2.DOWN * 420.0)
	_crear_bala_temporal(Vector2.DOWN.rotated(deg_to_rad(16.0)) * 420.0)

# TEMP: duplica la plantilla y le pasa la velocidad y el rect de arena para autodestruirse.
func _crear_bala_temporal(velocidad: Vector2) -> void:
	var bala := bullet_template.duplicate() as Area2D
	bullet_layer.add_child(bala)
	bala.visible = true
	bala.process_mode = Node.PROCESS_MODE_INHERIT
	bala.global_position = bullet_template.global_position
	bala.call("setup_temporal", velocidad, get_arena_rect())

func _obtener_margen_arena(player_node: CharacterBody2D) -> float:
	var collision_battle := player_node.get_node_or_null("CollisionBattle") as CollisionShape2D
	if collision_battle == null:
		return 32.0

	var circle_shape := collision_battle.shape as CircleShape2D
	if circle_shape == null:
		return 32.0

	return circle_shape.radius * collision_battle.scale.x

func _on_dead_transition_finished() -> void:
	SceneManager.change_to_dead()
