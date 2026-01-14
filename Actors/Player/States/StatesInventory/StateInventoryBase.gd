extends StateWorldBase
class_name StateInventoryBase

# Variables comunes
var seleccion := 0
var opciones: Array = []
var titulo: String = "Menú"

# Ciclo de vida común
func enter(_msg := {}):
	print("\n=== ", titulo, " ===")
	mostrar_opciones()

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		seleccion = (seleccion + 1) % opciones.size()
		mostrar_opciones()
	elif event.is_action_pressed("ui_up"):
		seleccion = (seleccion - 1 + opciones.size()) % opciones.size()
		mostrar_opciones()
	elif event.is_action_pressed("ui_action"):
		accion_seleccionada(opciones[seleccion])
	elif event.is_action_pressed("ui_support"):
		state_machine.pop_state()

# ==========================
# Métodos sobreescribibles
# ==========================
func accion_seleccionada(_opcion: String) -> void:
	print("> Acción seleccionada:", _opcion)

func mostrar_opciones():
	print(titulo, ":")
	for i in range(opciones.size()):
		if i == seleccion:
			print(" → ", opciones[i])
		else:
			print("   ", opciones[i])
