extends InteractuableBase
class_name InteractuableBatalla

@export var iniciar_batalla := true

func interact(player) -> void:
	print(nombre + ":")

	var dialog_state := WorldInteract.new()
	var controlador := get_tree().get_first_node_in_group("world_controller")
	var dialogo := obtener_dialogo()

	if dialogo.is_empty():
		dialogo = [
			"Asi que has llegado hasta mi...",
			"Veamos si eres digno."
		]

	if controlador and controlador.has_method("_on_battle_requested"):
		dialog_state.connect("battle_requested", Callable(controlador, "_on_battle_requested"))

	player.state_machine.push_state(dialog_state, {
		"dialogo": dialogo,
		"npc": self,
		"iniciar_batalla": iniciar_batalla
	})
