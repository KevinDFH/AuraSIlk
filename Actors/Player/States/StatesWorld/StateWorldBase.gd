extends PlayerStateBase
class_name StateWorldBase

@export var velocidad_base: float = 280.0
@export var velocidad_correr: float = 320.0

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	if not player:
		return

	var direccion := obtener_direccion()

	if Input.is_action_pressed("ui_speed"):
		velocidad = velocidad_correr
	else:
		velocidad = velocidad_base

	player.velocity = direccion * velocidad
	player.move_and_slide()

func physics_update(delta: float) -> void:
	pass


func _actualizar_direccion_raycast() -> void:
	interactor.target_position = direccion_actual * 250
