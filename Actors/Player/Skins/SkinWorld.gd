extends SkinBase
class_name SkinWorld

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var interactor: RayCast2D = $Interactor

func get_interactor() -> RayCast2D:
	return interactor
	
func on_enter_mode() -> void:
	print("🌿 Activado Skin World")
	#sprite.play("idle")

func on_exit_mode() -> void:
	print("Saliendo del modo World...")
