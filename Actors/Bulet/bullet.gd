extends Area2D

# Battle Prototipe: velocidad usada solo por el prototipo de bullet hell.
var velocity: Vector2 = Vector2.ZERO
# Battle Prototipe: rect de arena para eliminar la bala cuando salga de los limites.
var arena_rect: Rect2 = Rect2()
# Battle Prototipe: dano base temporal hasta definir tipos reales de proyectil.
var damage: int = 1

func _ready() -> void:
	# Battle Prototipe: grupo base para localizar proyectiles enemigos desde otras logicas.
	add_to_group("projectiles_enemy")
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += velocity * delta

	# Battle Prototipe: limpieza simple mientras no exista sistema final de colisiones/cleanup.
	if arena_rect.size != Vector2.ZERO and not arena_rect.grow(32.0).has_point(global_position):
		queue_free()

# Battle Prototipe: configuracion minima que el battle_controller le pasa al duplicar la bala.
func setup_temporal(nueva_velocidad: Vector2, nuevo_rect: Rect2) -> void:
	velocity = nueva_velocidad
	arena_rect = nuevo_rect

# Battle Prototipe: reenvia el impacto al jugador y deja que el jugador resuelva vida/animacion.
func _on_body_entered(body: Node) -> void:
	if body.has_method("receive_projectile_hit"):
		body.receive_projectile_hit(self, damage)
