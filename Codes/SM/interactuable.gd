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

# Llamado por el jugador cuando presiona el botón de interacción
@export var boss: Node

func interact(player):
	print(nombre + ":")

	var dialogo = [
		"Así que has llegado hasta mí...",
		"Veamos si eres digno."
	]

	player.state_machine.push_state(WorldInteract.new(), {
		"dialogo": dialogo,
		"npc": self,
		"iniciar_batalla": true
		})
# Opcional: si quieres mostrar feedback visual (por<zx ejemplo, que brille)
func set_apuntado(valor: bool) -> void:
	if valor != esta_apuntado:
		esta_apuntado = valor
		# Aquí podrías cambiar el sprite, el color, etc.
		if valor:
			modulate = Color(1, 1, 0.7) # leve brillo
		else:
			modulate = Color(1, 1, 1)
