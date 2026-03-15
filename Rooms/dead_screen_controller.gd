extends   Control

@onready var title_text: TextEdit = $TextEdit
@onready var checkpoint_button: Button = $Button

func _ready() -> void:
	if title_text:
		title_text.text = "YOU DIED"
		title_text.editable = false

	if checkpoint_button:
		checkpoint_button.text = "go back checkpoint"

	print("[DeadScreen] Lista la pantalla de derrota")

func on_retry_pressed() -> void:
	print("[DeadScreen] Retry placeholder")

func on_checkpoint_pressed() -> void:
	print("[DeadScreen] Checkpoint placeholder")

func on_quit_pressed() -> void:
	print("[DeadScreen] Quit placeholder")


func _on_button_pressed() -> void:
	SceneManager.change_to_world()
