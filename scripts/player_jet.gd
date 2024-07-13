extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

@export var max_speed : float = 400
@export var acceleration : float = 500
@export var deceleration : float = 0.02 # percentage of max speed
@export var rotation_speed : float = 0.05 # in radians

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		sprite.play("driving")
	elif velocity == Vector2.ZERO:
		sprite.play("idle")

	move_and_collide(velocity * delta)

func _physics_process(delta: float) -> void:
	# ROTATION
	if (velocity != Vector2.ZERO):
		var angle := global_position.angle_to_point(get_global_mouse_position())
		var last_global_rotation := global_rotation
		global_rotation = lerp_angle(last_global_rotation, angle, rotation_speed)

	# MOVEMENT
	if Input.is_action_pressed("ui_accept"):
		var direction := global_position.direction_to(get_global_mouse_position())
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	elif (velocity != Vector2.ZERO):
		velocity = lerp(velocity, Vector2.ZERO, 0.02)
		velocity = _round_vec2_to_whole(velocity)

func _round_vec2_to_whole(vector: Vector2) -> Vector2:
	if vector.x < 0:
		vector.x = ceil(velocity.x)
	elif vector.x > 0:
		vector.x = floor(velocity.x)

	if vector.y < 0:
		vector.y = ceil(velocity.y)
	elif vector.y > 0:
		vector.y = floor(velocity.y)

	return vector