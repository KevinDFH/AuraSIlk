extends StateBattleBase
class_name BattleIdle




# ===============================
#   INPUT
# ===============================
func handle_input(event: InputEvent) -> void:
	super.handle_input(event)
	
	if event.is_action_pressed("ui_action"):
		player.vida=0

	elif event.is_action_pressed("ui_speed"):
		print("¡Dash!")
		state_machine.push_state($"../BattleDash")
		start_dash_cooldown()

	elif event.is_action_pressed("ui_support"):
		print("Intentas convencer...") 

# ===============================
#   UPDATE
# ===============================
func update(delta: float) -> void:
	super.update(delta)
	# Aquí luego se podrán agregar animaciones de idle
	if player.vida==0:
		state_machine.change_state($"../BattleDead")
# ===============================
#   CICLO DE VIDA
# ===============================
func enter(_msg := {}) -> void:
	print("⚔️ Jugador ahora está en BattleIdle")

	# --- Activar colisiones del modo batalla ---
	_toggle_battle_collisions(true)

	# --- Desactivar colisiones del modo mundo ---
	_toggle_world_collisions(false)
	_toggle_interactor(false)
	_toggle_dashbox(false)

func exit() -> void:
	print("🏳️ Saliendo de BattleIdle")

	# --- Restaurar colisiones del modo mundo ---
	_toggle_battle_collisions(false)
	_toggle_world_collisions(true)
	_toggle_interactor(true)
	_toggle_dashbox(true)
