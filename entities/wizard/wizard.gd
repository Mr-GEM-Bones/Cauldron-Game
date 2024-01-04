extends Node2D

@onready var potion_sprite = $Path2D/PathFollow2D/ThrownPotion
@onready var anim = $PotionAnimation
signal sig_end_combat
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#throws potion
func throw_potion():
	potion_sprite.visible = true
	anim.play("potion_throw")
	#if anim.animation_finished("potion_throw"):
		#pass

#ends combat when potion hits
func _on_potion_animation_animation_finished(_anim_name):
	potion_sprite.visible = false
	emit_signal("sig_end_combat")
