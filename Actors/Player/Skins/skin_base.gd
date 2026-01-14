# res://player/skins/skin_base.gd
extends Node2D
class_name SkinBase

# Referencia al Player que lo controla
var player: Player

func activar() -> void:
	show()
	set_process(true)
	set_physics_process(true)

func desactivar() -> void:
	hide()
	set_process(false)
	set_physics_process(false)

# Puedes sobreescribir estos en cada skin
func on_enter_mode() -> void:
	pass

func on_exit_mode() -> void:
	pass
