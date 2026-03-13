extends Node
class_name Scene_Manager

func _ready() -> void:
	print("[SceneManager] Ready.")

func change_scene_to_file(scene_path: String) -> void:
	if scene_path.is_empty():
		push_warning("SceneManager recibio una ruta vacia.")
		return

	get_tree().change_scene_to_file(scene_path)
func change_to_battle(scene_path: String = "res://Rooms/battle_scene.tscn") -> void:
	change_scene_to_file(scene_path)
func change_to_dead(scene_path: String = "res://Rooms/you_died.tscn") -> void:
	change_scene_to_file(scene_path)
func change_to_world(scene_path: String = "res://Rooms/test_room_1.tscn") -> void:
	change_scene_to_file(scene_path)
