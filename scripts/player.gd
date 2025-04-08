# Author: Abigail Irvin
extends CharacterBody2D


const SPEED: float = 300.0
var win_state: int = 0
var paused: bool = false
@export var MainUi: Control = null
@export var firefly_count: int = 0
@export var time_left: float = 90
@onready var firefly_jar = preload("res://scenes/firefly_jar.tscn")

func _ready() -> void:
	MainUi.toggle_pause_menu(paused)

func _physics_process(delta: float) -> void:
	# Description
	# ----------
	# Basic physics process that handles basic movement for player.
	#
	# Parameters
	# ----------
	# delta : float
	#	represents the time between frames, used to do time-based calculations
	if is_locked():
		return
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
	# Description
	# ----------
	# Basic input process that handles pickup / drop commands. as well as
	# pausing / unpausing the game.
	#
	# Parameters
	# ----------
	# event : InputEvent
	#	input event given by user
	if event.is_action_pressed("pause"):
		toggle_pause()
	if is_locked():
		return
	if event.is_action_pressed("drop") and firefly_count > 0:
		firefly_count -= 1
		var instance = firefly_jar.instantiate()
		get_tree().root.add_child(instance)
		instance.global_position = self.global_position
		
func is_locked() -> bool:
	# Description
	# ----------
	# Returns a bool stating if the game should be considered "locked"
	# i.e. paused or won/lost.
	return win_state or time_left < 0.0 or paused
	
func add_light() -> void:
	# Description
	# ----------
	# Callback function activated whenever the player picks up a light jar.
	firefly_count += 1

func win_game() -> void:
	# Description
	# ----------
	# Callback function activated when player runs across the win area.
	win_state = 1

func toggle_pause() -> void:
	if not (win_state or time_left < 0.0):
		paused = !paused
		MainUi.toggle_pause_menu(paused)
		
func exit_game() -> void:
	print("quit! :3")
