extends Node

var walking = true
var combat = false
@onready var timer = $EnemyTimer
@onready var enemy_anim = $EnemyPath/EnemyAnimation
@onready var potion_anim = $Wizard/PotionAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#toggle combat
	
	
	#make background move while walking
	if walking == true:
		$ParallaxBackground.scroll_offset.x -= 200 * delta

func _input(_ev):
	#start and stop walking

	#if Input.is_key_pressed(KEY_W):
	#	if walking == true:
	#		walking = false
	#	elif walking == false and anim.is_playing() == false:
	#		walking = true

	#throw poiton
	if Input.is_key_pressed(KEY_T) and combat == true and potion_anim.is_playing() == false:
		$Wizard.throw_potion()


func end_combat():
	timer.wait_time = 6
	combat = false
	enemy_anim.play("RESET")
	walking = true
	timer.paused = false
	print(timer.wait_time)
	

func _on_enemy_timer_timeout():
	enemy_anim.play("enemy_animation")
	timer.paused = true
	
func _on_enemy_animation_animation_finished(anim_name):
	if anim_name == "enemy_animation":
		combat = true
		walking = false
		print(anim_name)
	

func _on_wizard_sig_end_combat():
	end_combat()
