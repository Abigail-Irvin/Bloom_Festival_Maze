extends Control
@export var firefly_text_ref: RichTextLabel = null 
@export var timer_text_ref: RichTextLabel = null
@export var max_fireflies: int = 2
@export var playerNode: Node = null
@export var pauseMenu: Node = null
@export var endMenu: Node = null
@export var endBlurb: RichTextLabel = null

func ui_update(count: int, time_left: float) -> void:
	firefly_text_ref.text = str(count) + "/" + str(max_fireflies)
	timer_text_ref.text = "Time left: " + str("%0.2f" % time_left, " s")


func _on_return_pressed() -> void:
	if playerNode:
		playerNode.toggle_pause()


func _on_quit_pressed() -> void:
	get_tree().quit()

func toggle_pause_menu(paused: bool):
	pauseMenu.set_visible(paused)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func end_game() -> void:
	if playerNode:
		if playerNode.win_state:
			endBlurb.text = "Congratulations! You made it through the scary forest faster than I even thought possible! Welcome to the festival!"
		else:
			endBlurb.text = "Oh no! You got lost in the forest, you almost had it just give it another try!"
		endMenu.set_visible(true)
