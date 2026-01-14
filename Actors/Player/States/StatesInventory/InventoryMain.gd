extends StateInventoryBase
class_name InventoryMain

func _init():
	titulo = "Inventario principal"
	opciones = ["Items", "Stats", "Book", "Config", "Salir"]

func accion_seleccionada(opcion: String) -> void:
	match opcion:
		"Items": state_machine.push_state(InventoryItems.new())
		"Stats": state_machine.push_state(InventoryStats.new())
		"Salir": state_machine.pop_state()
'''
		"Vookk": state_machine.push_state(InventoryBook.new())
		"Config": state_machine.push_state(InventoryConfig.new())
		"Save": state_machine.push_state(InventoryConfig.new()) '''
