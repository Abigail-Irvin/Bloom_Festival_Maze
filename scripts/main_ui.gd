extends Control
@export var firefly_text_ref: RichTextLabel = null 
@export var timer_text_ref: RichTextLabel = null
@export var max_fireflies: int = 2
@export var playerNode: Node = null
@export var pauseMenu: Node = null

func ui_update(count: int, time_left: float) -> void:
	firefly_text_ref.text = str(count) + "/" + str(max_fireflies)
	timer_text_ref.text = "Time left: " + str("%0.2f" % time_left, " s")


func _on_return_pressed() -> void:
	if playerNode:
		playerNode.toggle_pause()


func _on_quit_pressed() -> void:
	if playerNode:
		playerNode.exit_game()

func toggle_pause_menu(paused: bool):
	pauseMenu.set_visible(paused)
