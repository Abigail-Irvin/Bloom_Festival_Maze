extends CharacterBody2D


const SPEED = 300.0
@export var MainUi: Control = null
@export var firefly_count: int = 0
@export var time_left: float = 90
@onready var firefly_jar = preload("res://scenes/firefly_jar.tscn")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_axis := Input.get_axis("ui_left", "ui_right")
	if x_axis:
		velocity.x = x_axis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var y_axis := Input.get_axis("ui_up", "ui_down")
	if y_axis:
		velocity.y = y_axis * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	time_left -= delta
	MainUi.ui_update(firefly_count, time_left)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop") and firefly_count > 0:
		firefly_count -= 1
		var instance = firefly_jar.instantiate()
		get_tree().root.add_child(instance)
		instance.global_position = self.global_position
		

func add_light() -> void:
	firefly_count += 1
