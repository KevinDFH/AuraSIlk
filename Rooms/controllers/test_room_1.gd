extends Node2D

func _ready() -> void:
	add_to_group("world_controller")

func _on_battle_requested(npc: Node) -> void:
	if GameManager.player:
		GameManager.return_scene_path = "res://Rooms/test_room_1.tscn"
		GameManager.return_position = GameManager.player.global_position

	GameManager.solicitar_batalla({
		"npc_path": str(npc.get_path()),
		"npc_name": npc.name
	})

	var jugador := GameManager.player
	if jugador:
		jugador.state_machine.change_state(jugador.get_node("StateMachine/BattleEnter"))

func _on_battle_transition_finished() -> void:
	SceneManager.change_to_battle()
