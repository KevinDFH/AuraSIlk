extends StateInventoryBase
class_name InventoryItems

func _init():
	titulo = "Items"
	opciones = ["Poción", "Éter", "Carta misteriosa"]

func accion_seleccionada(opcion: String) -> void:
	print("> Usaste:", opcion)
