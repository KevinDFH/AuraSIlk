extends StateInventoryBase
class_name InventoryStats

func _init():
	titulo = "Estadísticas"
	opciones = ["Ataque", "Defensa", "Karma", "Velocidad"]

func accion_seleccionada(opcion: String) -> void:
	print("> Mostrando info de:", opcion)
