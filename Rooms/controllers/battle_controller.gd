extends Node2D

const PLAYER_SCENE := preload("res://Actors/Player/Player.tscn")

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var corner_right_up: Marker2D = $CornerRightUp
@onready var corner_left_bottom: Marker2D = $CornerLeftBottom

var arena_layer: Node2D = null
var jugador: CharacterBody2D = null
var arena_margin: float = 0.0

func _ready() -> void:
	add_to_group("battle_controller")
	GameManager.game_mode = GameManager.GameMode.BATTLE
	_preparar_arena_layer()
	_crear_jugador_batalla()

func _physics_process(_delta: float) -> void:
	if jugador == null:
		return

	var min_x: float = min(corner_left_bottom.global_position.x, corner_right_up.global_position.x) + arena_margin
	var max_x: float = max(corner_left_bottom.global_position.x, corner_right_up.global_position.x) - arena_margin
	var min_y: float = min(corner_left_bottom.global_position.y, corner_right_up.global_position.y) + arena_margin
	var max_y: float = max(corner_left_bottom.global_position.y, corner_right_up.global_position.y) - arena_margin

	var clamped_position := jugador.global_position
	clamped_position.x = clamp(clamped_position.x, min_x, max_x)
	clamped_position.y = clamp(clamped_position.y, min_y, max_y)
	jugador.global_position = clamped_position

func _preparar_arena_layer() -> void:
	arena_layer = canvas_layer.get_node_or_null("ArenaLayer") as Node2D
	if arena_layer == null:
		arena_layer = Node2D.new()
		arena_layer.name = "ArenaLayer"
		canvas_layer.add_child(arena_layer)

func _crear_jugador_batalla() -> void:
	jugador = PLAYER_SCENE.instantiate()
	arena_layer.add_child(jugador)

	jugador.global_position = player_spawn.global_position
	jugador.load_stats()
	jugador.set_skin("battle")
	jugador.state_machine.change_state(jugador.get_node("StateMachine/BattleIdle"))
	arena_margin = _obtener_margen_arena(jugador)

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
