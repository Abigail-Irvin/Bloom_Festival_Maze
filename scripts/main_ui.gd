extends Control
@export var firefly_text_ref: RichTextLabel = null 
@export var timer_text_ref: RichTextLabel = null
var max_fireflies: int = 3
@export var playerNode: Node = null
@export var pauseMenu: Node = null
@export var endMenu: Node = null
@export var endBlurb: RichTextLabel = null

func ui_update(count: int) -> void:
	firefly_text_ref.text = str(count) + "/" + str(max_fireflies)

func _on_return_pressed() -> void:
	if playerNode:
		playerNode.toggle_pause()


func _on_quit_pressed() -> void:
	get_tree().quit()

func toggle_pause_menu(paused: bool):
	pauseMenu.set_visible(paused)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func end_game(time: float) -> void:
	if playerNode:
		if playerNode.win_state:
			endBlurb.text = "Congratulations! You made it through the maze in" + str("%0.2f" % time, " s")
		endMenu.set_visible(true)
