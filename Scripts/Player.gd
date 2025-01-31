extends CharacterBody2D

# CONSTANTS (Values that never change)
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# VARIABLES
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")
var color = 0
var isInside = false

@onready var animated_sprite = $AnimatedSprite2D

# Signals
signal change_color(color)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("Fall")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction == 1 and is_on_floor():
		velocity.x = direction * SPEED
		animated_sprite.flip_h = true
		if is_on_floor():
			animated_sprite.play("Walk")
	elif direction == -1 and is_on_floor():
		velocity.x = direction * SPEED
		animated_sprite.flip_h = false
		if is_on_floor():
			animated_sprite.play("Walk")
	elif direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("Idle")
	
	# resets the level if the player falls out of the level
	if position.y > height:
		get_tree().reload_current_scene()
	
	#_set_color(color)
	_paint_bucket(color)

	move_and_slide()

# function to check if the player is by a paint bucket and uses it. The button is 'e' by default.
func _paint_bucket(color):
	if isInside == true:
		if color == 1:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(0,.5,1) # Blue
				change_color.emit(color)
			
		if color == 2:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(1,.2,.2) # Red
				change_color.emit(color)
				
		if color == 3:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(1,1,0) # Yellow
				change_color.emit(color)
				
		if color == 4:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(.63,.33,1) # Purple
				change_color.emit(color)
				
		if color == 5:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(0,1,0) # Green
				change_color.emit(color)
				
		if color == 6:
			if Input.is_action_just_pressed("color"):
				animated_sprite.modulate = Color(1,.67,0,1) # Orange
				change_color.emit(color)

"""
The code below this is for the obstacle collision. It resets the level on collision.
- Conner
"""

func _on_obstacle_body_entered(body):
	get_tree().reload_current_scene()

"""
The code below this point are signals needed for the paint buckets to communicate with the player.

The top function will be when the player enters the collider of the paint bucket. It flags a
boolean variable and sets the color equal to whatever the bucket's color id is.

The bottom function tells the program that the player is no longer in the bucket.
- Conner
"""

# Blue bucket enter
func _on_blue_bucket_body_entered(body):
	isInside = true
	color = 1
	
# Blue bucket exit
func _on_blue_bucket_body_exited(body):
	isInside = false
	
# Red bucket enter
func _on_red_bucket_body_entered(body):
	isInside = true
	color = 2

# Red bucket exit
func _on_red_bucket_body_exited(body):
	isInside = false

# Yellow bucket enter
func _on_yellow_bucket_body_entered(body):
	isInside = true
	color = 3
	
# Yellow bucket exit
func _on_yellow_bucket_body_exited(body):
	isInside = false

# Purple bucket enter
func _on_purple_bucket_body_entered(body):
	isInside = true
	color = 4

# Purple bucket exit
func _on_purple_bucket_body_exited(body):
	isInside = false

# Green bucket enter
func _on_green_bucket_body_entered(body):
	isInside = true
	color = 5

# Green bucket exit
func _on_green_bucket_body_exited(body):
	isInside = false

# Orange bucket enter
func _on_orange_bucket_body_entered(body):
	isInside = true
	color = 6

# Orange bucket exit
func _on_orange_bucket_body_exited(body):
	isInside = false
