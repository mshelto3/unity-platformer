extends KinematicBody2D
 
const MOVE_SPEED = 600
const JUMP_FORCE = 500
const GRAVITY = 50
 
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
 
var y_velo = 0
var facing_right = true
 
func _physics_process(delta):
    var move_dir = 0
    if Input.is_action_pressed("move_right"):
        move_dir += 1
    if Input.is_action_pressed("move_left"):
        move_dir -= 1
    move_and_slide(Vector2(move_dir * MOVE_SPEED, 0), Vector2(0, -1))
    
    var grounded = is_on_floor();
    print(grounded)
    if grounded and Input.is_action_just_pressed("jump"):
        y_velo = -JUMP_FORCE
    if grounded and y_velo >= 5:
        y_velo = 5
   
    if facing_right and move_dir < 0:
        flip()
    if !facing_right and move_dir > 0:
        flip()
   
    if grounded:
        if move_dir == 0:
            play_anim("idle")
        else:
            play_anim("walk")
    else:
        play_anim("jump")
 
func flip():
    facing_right = !facing_right
    sprite.flip_h = !sprite.flip_h
 
func play_anim(anim_name):
    if anim_player.is_playing() and anim_player.current_animation == anim_name:
        return
    anim_player.play(anim_name)