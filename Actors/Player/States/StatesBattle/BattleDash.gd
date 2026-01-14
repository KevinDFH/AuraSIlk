extends StateBattleBase
class_name BattleDash

@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.15

var dash_timer: float = 0.0
var direccion_dash: Vector2 = Vector2.DOWN
var is_dashing: bool = false

func enter(_msg := {}) -> void:
	if not player:
		return
	print("⚡ Iniciando dash...")

	var dir_input = obtener_direccion()
	if dir_input != Vector2.ZERO:
		direccion_dash = dir_input.normalized()
	elif direccion_actual != null:
		direccion_dash = direccion_actual.normalized()
	else:
		direccion_dash = Vector2.DOWN

	player.velocity = direccion_dash * dash_speed
	player.set_invulnerable(true)
	is_dashing = true
	dash_timer = dash_duration

func update(delta: float) -> void:
	if not player:
		return

	if is_dashing:
		player.move_and_slide()
		dash_timer -= delta
		if dash_timer <= 0:
			_finalizar_dash()

func exit() -> void:
	if player:
		player.set_invulnerable(false)
	is_dashing = false

func _finalizar_dash() -> void:
	is_dashing = false
	player.velocity = Vector2.ZERO
	player.set_invulnerable(false)
	print("⏹️ Dash terminado.")
	state_machine.pop_state()
