extends SkinBase
class_name SkinBattle

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var parryzone: Area2D = $ParryZone
@onready var cuerpo: CollisionShape2D = $Cuerpo

func on_enter_mode() -> void:
	print("🔥 Activado Skin Battle")

func on_exit_mode() -> void:
	print("Saliendo del modo Battle...")

# ==================================================
# Invulnerabilidad (llamado desde BattleDash o Player)
# ==================================================
func _set_invulnerable_state(activo: bool) -> void:
	if not hurtbox:
		return

	if activo:
		print("🛡️ Invulnerabilidad activada")
		# Desactivar colisiones con proyectiles (capa 2)
		hurtbox.set_collision_mask_value(2, false)
		cuerpo.disabled = true
		print("desactivado")
	else:
		print("💥 Invulnerabilidad desactivada")
		hurtbox.set_collision_mask_value(2, true)
		cuerpo.disabled = true
