extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

func _physics_process(delta: float) -> void:
	var angle := global_position.angle_to_point(get_global_mouse_position())
	var last_global_rotation := global_rotation
	global_rotation = lerp_angle(last_global_rotation, angle, .05)

	if Input.is_action_pressed("ui_up"):
		var direction := global_position.direction_to(get_local_mouse_position())
		velocity = velocity.move_toward(direction * 300, 100 * delta)

	move_and_slide()