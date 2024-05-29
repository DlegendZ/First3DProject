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



func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("i touch")


func _on_body_entered(body):
	print("i touch")
