@tool
extends Node3D

@export var grass_scene: PackedScene
@export var scatter_count: int = 150
@export var area_size: Vector2 = Vector2(20, 20)
@export var random_scale_range: Vector2 = Vector2(0.8, 1.2)

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
		push_warning("Achtung: Es wurde keine Graszene zugewiesen!")
		return

	# Die aktuell geöffnete Hauptszene ermitteln, damit die Kinder dort gespeichert werden
	var root = get_tree().edited_scene_root
	if not root:
		push_warning("Achtung: Keine editierte Szene gefunden!")
		return

	for i in range(scatter_count):
		var instance = grass_scene.instantiate() as Node3D
		if not instance:
			continue
		
		# Als Kind hinzufügen
		add_child(instance)
		
		# WICHTIG: Damit Godot die Kinder in der .tscn-Datei speichert
		instance.owner = root
		
		# Zufällige Position im Bereich
		var pos_x = randf_range(-area_size.x / 2, area_size.x / 2)
		var pos_z = randf_range(-area_size.y / 2, area_size.y / 2)
		instance.position = Vector3(pos_x, 0, pos_z)
		
		# Zufällige Skalierung
		var scale_val = randf_range(random_scale_range.x, random_scale_range.y)
		instance.scale = Vector3(scale_val, scale_val, scale_val)

func _clear_scatter() -> void:
	var children = get_children()
	for child in children:
		child.queue_free() # Oder child.free()
