extends PlayerStateBase
class_name BattleDead

@export var death_time := 2

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	print("☠️ Jugador ha muerto")

	_toggle_battle_collisions(false)
	_toggle_world_collisions(false)
	_toggle_interactor(false)
	_toggle_dashbox(false)

	player.set_invulnerable(true)
	#player.play_anim("death", "down") # si existe, si no, default

	await get_tree().create_timer(death_time).timeout

	GameManager.emit_signal("battle_ended", "player_dead")
