extends StaticBody2D
class_name Interactable
#crear base para esto
# ==========================
#  VARIABLES Y SEÑALES
# ==========================
var nombre: String = "Vokk"
# (Opcional) para mostrar si está siendo apuntado
var esta_apuntado: bool = false

# ==========================
#  MÉTODOS PRINCIPALES
# ==========================

func interact(player):
	print(nombre + ":")

	var dialogo = [
		"Asi que has llegado hasta mi...",
		"Veamos si eres digno."
	]

	var dialog_state := WorldInteract.new()
	var current_scene :Tree= player.get_tree().current_scene

	if current_scene and current_scene.has_method("_on_battle_requested"):
		dialog_state.connect("battle_requested", Callable(current_scene, "_on_battle_requested"))

	player.state_machine.push_state(dialog_state, {
		"dialogo": dialogo,
		"npc": self,
		"iniciar_batalla": true
	})

func set_apuntado(valor: bool) -> void:
	if valor != esta_apuntado:
		esta_apuntado = valor
		if valor:
			modulate = Color(1, 1, 0.7)
		else:
			modulate = Color(1, 1, 1)
