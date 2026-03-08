extends Node
class_name Scene_Manager

# Deprecated manager kept as placeholder.
# Battle/world mode transitions are handled by Player states + GameManager signals.
func _ready() -> void:
	print("[SceneManager] Disabled. Player states manage transitions.")
