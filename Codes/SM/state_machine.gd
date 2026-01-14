extends Node
class_name StateMachine

@export var initial_state: StateBase
var current_state: StateBase = null
var owner_node: Node = null
var state_stack: Array[StateBase] = []

func _ready() -> void:
	owner_node = get_parent()
	if initial_state:
		change_state(initial_state)

# ================================
#   DELEGACIÓN DE EVENTOS
# ================================
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

# ================================
#   CAMBIO DE ESTADO NORMAL
# ================================
func change_state(new_state: StateBase, msg: Dictionary = {}) -> void:
	for s in state_stack:
		if s:
			s.exit()
	state_stack.clear()
	if current_state:
		current_state.exit()
	state_stack.clear()
	_set_state(new_state, msg)

# ================================
#   PUSH / POP DE ESTADOS (Stack)
# ================================
func push_state(new_state: StateBase, msg: Dictionary = {}) -> void:
	if current_state:
		state_stack.push_back(current_state)
	_set_state(new_state, msg)

func pop_state() -> void:
	if current_state:
		current_state.exit()

	if state_stack.size() > 0:
		var prev_state = state_stack.pop_back()
		_set_state(prev_state)
	else:
		print("⚠️ No hay más estados en la pila.")

# ================================
#   AUXILIAR
# ================================
func _set_state(new_state: StateBase, msg: Dictionary = {}) -> void:
	current_state = new_state
	if current_state:
		current_state.state_machine = self
		current_state.owner = owner_node
		current_state.enter(msg)
