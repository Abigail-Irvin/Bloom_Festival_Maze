extends Control
@export var firefly_text_ref: RichTextLabel = null 
@export var timer_text_ref: RichTextLabel = null
@export var max_fireflies: int = 2

func ui_update(count: int, time_left: float) -> void:
	firefly_text_ref.text = str(count) + "/" + str(max_fireflies)
	timer_text_ref.text = "Time left: " + str("%0.2f" % time_left, " s")
