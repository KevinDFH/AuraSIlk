extends StateWorldBase
class_name WorldInteract

# ===============================
#   VARIABLES
# ===============================
var dialogo_actual: Array = []
var indice_linea: int = 0
var npc_origen: Node = null
var data_msg := {}
# ===============================
#   CICLO DE VIDA DEL ESTADO
# ===============================
func enter(msg := {}) -> void:
	print("🗨️ Entrando en modo interacción.")
	data_msg = msg

	if msg.has("dialogo"):
		dialogo_actual = msg["dialogo"]
	if msg.has("npc"):
		npc_origen = msg["npc"]

	if dialogo_actual.size() > 0:
		_mostrar_linea_actual()
	else:
		print("(No hay diálogo para mostrar)")



func exit() -> void:
	print("🗨️ Saliendo del modo interacción.")

# ===============================
#   INPUT (solo teclas de diálogo)
# ===============================
func handle_input(event: InputEvent) -> void:
	# Cualquier tecla Z, X o C avanza el texto
	if event.is_action_pressed("ui_speed") \
	or event.is_action_pressed("ui_action") \
	or event.is_action_pressed("ui_support"):
		avanzar_dialogo()

# ===============================
#   LÓGICA DE DIÁLOGO
# ===============================
func avanzar_dialogo() -> void:
	indice_linea += 1

	if indice_linea < dialogo_actual.size():
		_mostrar_linea_actual()
	else:
		print("💭 Fin del diálogo.")

		# Aquí aprovechamos los datos guardados
		if data_msg.has("iniciar_batalla") and npc_origen:
			GameManager.iniciar_batalla(npc_origen)
		else:
			state_machine.pop_state()

func _mostrar_linea_actual() -> void:
	print("> ", dialogo_actual[indice_linea])
