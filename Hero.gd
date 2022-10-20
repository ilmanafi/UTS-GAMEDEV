extends KinematicBody2D

var laju_cepat = 160
var laju_normal = 80
var laju = laju_normal
var kecepatan = Vector2.ZERO
var laju_lompat = -280
var gravitasi = 12

onready var sprite = $Sprite

func _physics_process(delta):
	kecepatan.y = kecepatan.y + gravitasi
	if(Input.is_action_pressed("move_right")):
		kecepatan.x = laju
	if(Input.is_action_pressed("move_left")):
		kecepatan.x = -laju
	if(Input.is_action_just_pressed("fast_run")):
		lari_cepat()
	
	if(Input.is_action_pressed("jump")and is_on_floor()):
		kecepatan.y = laju_lompat
		
	kecepatan.x = lerp(kecepatan.x, 0, 0.2)
	kecepatan = move_and_slide(kecepatan, Vector2.UP)
	
	update_animasi()

func update_animasi():
	if is_on_floor():
		if kecepatan.x < (laju * 0.5) and kecepatan.x > (-laju * 0.5):
			sprite.play("diam")
		else:
			if laju == laju_normal:
				sprite.play("lari")
			elif laju == laju_cepat:
				sprite.play("lariCepat")
	else:
		if kecepatan.y > 0:
			sprite.play("lompat")
		else:
			sprite.play("jatuh")
	
	sprite.flip_h = false
	if kecepatan.x < 0:
		sprite.flip_h = true

func lari_cepat():
	laju = laju_cepat
	$Timer.start()

func _on_Timer_timeout():
	laju = laju_normal
