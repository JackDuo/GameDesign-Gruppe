@tool
extends Node3D


@export var grass_scene: PackedScene
@export var scatter_count: int = 150
@export var fallback_size: Vector2 = Vector2(20, 20) ## Wird genutzt, wenn kein Mesh da ist
@export var random_scale_range: Vector2 = Vector2(0.8, 1.2)

@export_category("Visueller Bereich")
@export var area_mesh: MeshInstance3D ## Ziehe hier deine MeshInstance3D (mit BoxMesh) rein

@export var generate: bool = false:
	set(val):
		generate = val
		if val and Engine.is_editor_hint():
			_clear_scatter()
			_generate_scatter()
			call_deferred("_reset_generate")

@export var clear: bool = false:
	set(val):
		clear = val
		if val and Engine.is_editor_hint():
			_clear_scatter()
			call_deferred("_reset_clear")

func _reset_generate() -> void:
	generate = false

func _reset_clear() -> void:
	clear = false

func _generate_scatter() -> void:
	if not grass_scene:
		push_warning("Achtung: Keine Graszene zugewiesen!")
		return

	var root = get_tree().edited_scene_root
	if not root:
		return

	# Standardwerte auf Fallback setzen
	var box_size = Vector3(fallback_size.x, 0, fallback_size.y)
	var box_center = Vector3.ZERO

	# Prüfen, ob das Mesh da ist und eine Box besitzt
	if area_mesh and area_mesh.mesh:
		# Wir holen die AABB (Achsen-ausgerichtete Bounding Box) des Meshes
		# Das funktioniert automatisch für BoxMesh, CapsuleMesh, etc. und berücksichtigt Skalierung!
		var aabb = area_mesh.mesh.get_aabb()
		box_size = aabb.size * area_mesh.scale
		box_center = area_mesh.position + (aabb.position * area_mesh.scale) + (box_size / 2.0)
		print("Test1234", fallback_size.y)
		print("Erfolgreich Mesh-Größe ausgelesen: ", box_size)
	else:
		print("Kein Mesh gefunden, nutze Fallback-Größe: ", fallback_size)

	for i in range(scatter_count):
		var instance = grass_scene.instantiate() as Node3D
		if not instance:
			continue
		
		add_child(instance)
		instance.owner = root
		
		# Zufällige Position innerhalb der ermittelten Box
		var pos_x = randf_range(box_center.x - box_size.x / 2, box_center.x + box_size.x / 2)
		var pos_z = randf_range(box_center.z - box_size.z / 2, box_center.z + box_size.z / 2)
		instance.position = Vector3(pos_x, box_center.y, pos_z)
		
		# Zufällige Skalierung
		var scale_val = randf_range(random_scale_range.x, random_scale_range.y)
		instance.scale = Vector3(scale_val, scale_val, scale_val)

func _clear_scatter() -> void:
	var children = get_children()
	for child in children:
		if child == area_mesh:
			continue
		child.queue_free()
