extends KinematicBody2D

signal shoot(Bullet, bullet_position, bullet_rotation_degrees)
signal die

var Bullet = preload("res://src/Other/Enemy_Bullet.tscn")

var velocity = Vector2()
var acceleration = Vector2()
export var mass = 1.0
export var speed = 30
export var friction_num = 0.1

var hp = 100

func apply_force(f: Vector2):
    acceleration += f / mass

func apply_friction():
    apply_force(velocity * -1 * friction_num)

var target_body: Node2D = null
var is_in_circle = false
func _on_Player_Deteter_body_entered(body):
    target_body = body
    is_in_circle = true

func _on_Player_Deteter_body_exited(body):
    is_in_circle = false

func move():
    var direction = Vector2()
    if target_body != null:
        direction = (target_body.position - position).normalized()
        apply_force(direction * speed)
        if is_in_circle:
            apply_force(direction * -1 * speed)

func rotate_gun():
    if target_body != null:
        $Gun.look_at(target_body.position)

func _on_Shooting_Timer_timeout():
    shooting_available = true

var shooting_available = true
func shoot():
    if target_body != null and shooting_available:
        $Shooting_Timer.start()
        shooting_available = false
        var bullet_position = position
        var bullet_rotation_degrees = rotation_degrees + $Gun.rotation_degrees
        emit_signal("shoot", Bullet, bullet_position, bullet_rotation_degrees)

func _on_Bullet_Deteter_area_entered(area):
    hp -= 5
    if hp <= 0:
        emit_signal("die")
        queue_free()

func _ready():
    connect("shoot", get_parent().get_parent(), "_on_Enemy_shoot")
    connect("die", get_parent().get_parent(), "_on_Enemy_die")

func _physics_process(delta):
    move()
    rotate_gun()
    shoot()
    apply_friction()
    
    velocity += acceleration
    velocity = move_and_slide(velocity)
    acceleration *= 0
