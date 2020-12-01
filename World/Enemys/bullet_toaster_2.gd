extends Area2D

var velocity = Vector2(-350,0)

func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle() * 5

func _on_bullet_toaster_1_body_exited(_body):
	queue_free()

func _on_free_timeout():
	queue_free()
