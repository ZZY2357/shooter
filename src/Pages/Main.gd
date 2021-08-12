extends Node2D

var Enemy = preload("res://src/Actors/Enemy.tscn")

func _on_Player_shoot(Bullet, bullet_position, bullet_rotation_degrees):
    var b = Bullet.instance()
    b.position = bullet_position
    b.rotation_degrees = bullet_rotation_degrees
    b.z_index = -99
    add_child(b)

func _on_Enemy_shoot(Bullet, bullet_position, bullet_rotation_degrees):
    var b = Bullet.instance()
    b.position = bullet_position
    b.rotation_degrees = bullet_rotation_degrees
    b.z_index = -99
    add_child(b)

func _on_Player_die():
    get_tree().change_scene("res://src/Pages/Game_Over.tscn")

func new_enemy():
    var e = Enemy.instance()
    var x = rand_range(100, 722)
    var y = rand_range(100, 530)
    e.position = Vector2(x, y)
    $Enemies_Container.add_child(e)

func _on_Enemy_die():
    PlayerVariable.score += 1
    $HUD/Score_Display/Score.text = PlayerVariable.score as String
    new_enemy()

func _ready():
    randomize()

