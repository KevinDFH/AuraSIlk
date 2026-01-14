extends StateWorldBase
class_name WorldIdle

# ========================================
# ENTRADA DE INPUTS
# ========================================
func handle_input(event: InputEvent) -> void:
	super.handle_input(event)

	if event.is_action_pressed("ui_inventory"):
		abrir_inventario(InventoryMain.new())

	if event.is_action_pressed("ui_action"):
		interactuar()


# ========================================
# INTERACCIÓN CON OBJETOS
# ========================================
func interactuar() -> void:
	if interactor and interactor.is_colliding():
		var objetivo = interactor.get_collider()
		if objetivo and objetivo.has_method("interact"):
			objetivo.interact(self)


# ========================================
# ACTUALIZACIÓN GENERAL
# ========================================
func update(delta: float) -> void:
	super.update(delta)
	# Aquí luego podemos meter animaciones básicas
	# if player and player.velocity.length() > 0.0:
	#     player.anim.play("walk")
	# else:
	#     player.anim.play("idle")


# ========================================
# FÍSICAS Y MOVIMIENTO
# ========================================
func physics_update(delta: float) -> void:
	var dir = obtener_direccion()
	if dir != Vector2.ZERO:
		direccion_actual = dir
		_actualizar_direccion_raycast()


# ========================================
# CICLO DE VIDA DEL ESTADO
# ========================================
func enter(_msg := {}) -> void:
	print("Jugador ahora está en WorldIdle")

	# Activar solo las colisiones del mundo
	_toggle_world_collisions(true)
	_toggle_battle_collisions(false)

	# Activar interactor y desactivar área de dash (no se usa en exploración)
	_toggle_interactor(true)
	_toggle_dashbox(false)


func exit() -> void:
	print("Saliendo de WorldIdle")

	# Al salir, desactivar colisiones del mundo e interacciones
	_toggle_world_collisions(false)
	_toggle_interactor(false)
