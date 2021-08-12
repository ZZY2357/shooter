extends KinematicBody2D

signal shoot(Bullet, bullet_position, bullet_rotation_degrees)
signal change_hp_progress(value)
signal die

var Bullet = preload("res://src/Other/Player_Bullet.tscn")

var velocity = Vector2()
var acceleration = Vector2()
export var mass = 1.0
export var speed = 30
export var friction_num = 0.1

var hp = 100

func apply_force(f: Vector2):
    acceleration += f / mass

func move():
    var direction = Vector2(
        Input.get_action_strength("move_right") - 
            Input.get_action_strength("move_left"),    
        Input.get_action_strength("move_down") - 
            Input.get_action_strength("move_up")
    )
    apply_force(direction * speed)

var shooting_available = true
func shoot():
    if Input.is_action_pressed("shoot") and shooting_available:
        $Shooting_Timer.start()
        shooting_available = false
        var bullet_position = position + $Gun.position
        var bullet_rotation_degrees = rotation_degrees + $Gun.rotation_degrees
        emit_signal("shoot", Bullet, bullet_position, bullet_rotation_degrees)

func _on_Shooting_Timer_timeout():
    shooting_available = true

func _on_Bullet_Deteter_area_entered(area):
    hp -= 5
    if hp <= 0:
        emit_signal("die")
    else:
        emit_signal("change_hp_progress", hp)

func apply_friction():
    apply_force(velocity * -1 * friction_num)

func _physics_process(delta):
    move()
    shoot()
    apply_friction()
    
    velocity += acceleration
    velocity = move_and_slide(velocity)
    acceleration *= 0
