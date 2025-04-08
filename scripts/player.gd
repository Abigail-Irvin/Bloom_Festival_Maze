# Author: Abigail Irvin
extends CharacterBody2D


const SPEED: float = 300.0
var win_state: bool = false
var paused: bool = true
@onready var MainUi: Control = $CanvasLayer/MainUi
@export var firefly_count: int = 2
@export var time_left: float = 90
@onready var animation_sprite: AnimatedSprite2D = $Animation
@onready var firefly_jar = preload("res://scenes/firefly_jar.tscn")
var game_over: bool = false

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
	if not game_over and is_locked():
		# lose condition
		game_over = true
		MainUi.end_game()
		
	if is_locked() or is_paused():
		return
	var x_axis := Input.get_axis("ui_left", "ui_right")
	var y_axis := Input.get_axis("ui_up", "ui_down")
	if x_axis:
		# moving left / right
		velocity.x = x_axis * SPEED
		if y_axis == 0:
			if x_axis > 0:
				animation_sprite.play("right")
			else:
				animation_sprite.play("left")
	else:
		# slowing down
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if y_axis:
		# moving up / down
		velocity.y = y_axis * SPEED
		if y_axis > 0:
			animation_sprite.play("down")
		else:
			animation_sprite.play("up")
	else:
		# slowing down
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
	if is_locked() or is_paused():
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
	return win_state or time_left < 0.0

func is_paused() -> bool:
	# Description
	# ----------
	# Returns a bool stating if the game is paused
	return paused
	
func add_light() -> void:
	# Description
	# ----------
	# Callback function activated whenever the player picks up a light jar.
	firefly_count += 1

func win_game() -> void:
	# Description
	# ----------
	# Callback function activated when player runs across the win area.
	win_state = true
	game_over = true
	MainUi.end_game()

func toggle_pause() -> void:
	if not (win_state or time_left < 0.0):
		paused = !paused
		MainUi.toggle_pause_menu(paused)
