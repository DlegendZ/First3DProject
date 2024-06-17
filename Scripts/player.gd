extends RigidBody3D
##this is a comment
@export_range(1000.0,2000.0) var force = 2000.0
##this is a force angular
@export var force_angular = 100
@onready var booster_particles = $BoosterParticles
@onready var booster_particles_right = $BoosterParticlesRight
@onready var booster_particles_left = $BoosterParticlesLeft
@onready var explosion_particles = $ExplosionParticles
@onready var success_particles = $SuccessParticles
@onready var done = false
@onready var audio_stream_player_3d = $AudioStreamPlayer3D

func _process(delta : float) -> void :
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	if Input.is_action_just_pressed("Restart") :
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("fly") :
		apply_central_force(basis.y * delta * force)
		booster_particles.emitting = true
	else :
		booster_particles.emitting = false
	
	if Input.is_action_pressed("left") :
		apply_torque(Vector3.BACK * delta * force_angular)
		booster_particles_right.emitting = true
		booster_particles_left.emitting = false
		
	elif Input.is_action_pressed("right") :
		apply_torque(Vector3.FORWARD * delta * force_angular)
		booster_particles_left.emitting = true
		booster_particles_right.emitting = false
	else :
		booster_particles_left.emitting = false
		booster_particles_right.emitting = false



func _on_body_entered(body):
	if body.name == "Landing" :
		complete_landing(body.next_level)
	elif body.is_in_group("Kaboom") and done == false:
		Kaboom()
		
func complete_landing(level) :
	print("I win")
	audio_stream_player_3d.stream = preload("res://Assets/Audio/SFX - Success.ogg")
	audio_stream_player_3d.play()
	done = true
	set_process(false)
	success_particles.emitting = true
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file(level)

func Kaboom() :
	print("Kaboom")
	audio_stream_player_3d.stream = preload("res://Assets/Audio/SFX - Death Explosion.ogg")
	audio_stream_player_3d.play()
	set_process(false)
	explosion_particles.emitting = true
	booster_particles_left.emitting = false
	booster_particles.emitting = false
	booster_particles_right.emitting = false
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
