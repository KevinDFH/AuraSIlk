extends StaticBody2D
class_name InteractuableBase

@export var nombre: String = "Interactuable"
@export_multiline var dialogo_texto: String = ""

var esta_apuntado: bool = false

func obtener_dialogo() -> Array[String]:
	if dialogo_texto.strip_edges().is_empty():
		return []

	var lineas_crudas := dialogo_texto.split("\n", false)
	var dialogo: Array[String] = []

	for linea in lineas_crudas:
		var texto := linea.strip_edges()
		if not texto.is_empty():
			dialogo.append(texto)

	return dialogo

func interact(_player) -> void:
	pass

func set_apuntado(valor: bool) -> void:
	if valor != esta_apuntado:
		esta_apuntado = valor
		if valor:
			modulate = Color(1, 1, 0.7)
		else:
			modulate = Color(1, 1, 1)
