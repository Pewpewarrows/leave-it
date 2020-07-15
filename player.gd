class_name Player
extends Node2D

onready var ray = $RayCast2D as RayCast2D

var speed = 512 # big number because it's multiplied by delta
var tile_size = 64 # size in pixels of tiles on the grid

var last_position = Vector2() # last idle position
var target_position = Vector2() # desired position to move towards
var movedir = Vector2() # move direction
var last_direction = Vector2(0, 1)


func _ready():
	position = position.snapped(Vector2(tile_size, tile_size)) # make sure player is snapped to grid
	last_position = position
	target_position = position


func _process(delta):
	# MOVEMENT
	if ray.is_colliding():
		position = last_position
		target_position = last_position
	else:
		position += speed * movedir * delta

		if position.distance_to(last_position) >= tile_size: # if we've moved further than one space
			position = target_position # snap the player to the intended position

	# IDLE
	if position == target_position:
		get_movedir()
		last_position = position # record the player's current idle position
		target_position += movedir * tile_size # if key is pressed, get new target (also shifts to moving state)

	# TODO: use move_and_slide?
	animate_player(movedir)


func is_idle() -> bool:
	return position == target_position


# GET DIRECTION THE PLAYER WANTS TO MOVE
func get_movedir():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")

	movedir.x = -int(LEFT) + int(RIGHT) # if pressing both directions this will return 0
	movedir.y = -int(UP) + int(DOWN)

	if movedir.x != 0 && movedir.y != 0: # prevent diagonals
		movedir = Vector2.ZERO

	if movedir != Vector2.ZERO:
		ray.cast_to = movedir * tile_size / 2


func animate_player(direction: Vector2) -> void:
	var animation: String
	var sprite := $Sprite as AnimatedSprite

	if direction != Vector2.ZERO:
		# gradually update last_direction to counteract the bounce of the analog stick
		last_direction = (0.5 * last_direction) + (0.5 * direction)

		# Choose walk animation based on movement direction
		animation = animation_direction(last_direction) + "_walk"
	else:
		# Choose idle animation based on last movement direction and play it
		animation = animation_direction(last_direction) + "_idle"

	# TODO: this still isn't playing the walk animations when tapping movement keys instead of holding them down
	if sprite.animation != animation:
		sprite.play(animation)


func animation_direction(direction: Vector2):
#	var norm_direction = direction.normalized()
	var norm_direction = direction

	if norm_direction.y >= 0.707:
		return "down"
	elif norm_direction.y <= -0.707:
		return "up"
	elif norm_direction.x <= -0.707:
		return "left"
	elif norm_direction.x >= 0.707:
		return "right"

	return "down"
