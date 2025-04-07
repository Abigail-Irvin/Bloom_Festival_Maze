extends Node2D
var player_ref: Node2D = null

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_ref = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_ref = body

func _input(event: InputEvent):
	if event.is_action_pressed("pickup") and player_ref:
		player_ref.add_light()
		queue_free()
