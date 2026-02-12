extends MultiMeshInstance3D



func _ready():
	var multiMesh = self.multimesh
	for index in range(multiMesh.instance_count):
		var meshTran = multiMesh.get_instance_transform(index)
		var shape = CollisionShape3D.new()
		shape.shape = multiMesh.mesh.create_trimesh_shape()  # Create a collision shape from the mesh
		shape.transform = meshTran  # Set the transform for the collision shape
		var sBody = StaticBody3D.new()  # Create a new static body
		sBody.add_to_group("map")
		sBody.transform = meshTran  # Set the transform for the static body
		sBody.add_child(shape)  # Add the collision shape to the static body
		self.add_child.call_deferred(sBody)  # Add the static body to the scene
