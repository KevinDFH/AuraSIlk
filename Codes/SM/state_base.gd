# res://scripts/state_base.gd
# ---------------------------
# Clase base para los estados. 
# Cualquier estado (Idle, Walk, Dash, Talk...) heredará de esta clase.
# Define métodos que la máquina de estados llamará automáticamente.
# Cada estado sabe:
#  - Qué máquina lo controla (state_machine).
#  - Qué nodo está controlando (owner o nodo_controlado, en tu caso el Player).
# ---------------------------

extends Node
class_name StateBase

var state_machine     # referencia a la máquina de estados que me contiene
@onready var controlled_node: Node = self.owner  # alias para mayor claridad

func enter(_msg: Dictionary = {}) -> void:
	# Qué hacer al entrar en este estado
	pass

func exit() -> void:
	# Qué hacer al salir de este estado
	pass

func handle_input(event: InputEvent) -> void:
	# Cómo responde este estado a las entradas del jugador
	pass

func update(delta: float) -> void:
	# Lógica frame a frame (equivalente a _process)
	pass

func physics_update(delta: float) -> void:
	# Lógica física (equivalente a _physics_process)
	pass
