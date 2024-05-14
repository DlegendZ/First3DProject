extends RigidBody3D
@export var force = 2000
@export var force_angular = 100

func _process(delta):
	if Input.is_action_pressed("fly") :
		apply_central_force(basis.y * delta * force)
	if Input.is_action_pressed("left") :
		apply_torque(Vector3.BACK * delta * force_angular)
	if Input.is_action_pressed("right") :
		apply_torque(Vector3.FORWARD * delta * force_angular)
