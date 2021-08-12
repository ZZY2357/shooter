extends Area2D

export var speed = 800

func _physics_process(delta):
    var velocity = Vector2(speed, 0).rotated(rotation)
    position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

func _on_Player_Bullet_body_entered(body):
    queue_free()
