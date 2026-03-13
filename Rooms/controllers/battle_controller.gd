extends Node2D

const PLAYER_SCENE := preload("res://Actors/Player/Player.tscn")

@onready var player_spawn: Node2D = $PlayerSpawn

func _ready() -> void:
	add_to_group("battle_controller")
	GameManager.game_mode = GameManager.GameMode.BATTLE
	_crear_jugador_batalla()

func _crear_jugador_batalla() -> void:
	var jugador := PLAYER_SCENE.instantiate()
	add_child(jugador)

	jugador.global_position = player_spawn.global_position
	jugador.load_stats()
	jugador.set_skin("battle")
	jugador.state_machine.change_state(jugador.get_node("StateMachine/BattleIdle"))

func _on_dead_transition_finished() -> void:
	SceneManager.change_to_dead()
