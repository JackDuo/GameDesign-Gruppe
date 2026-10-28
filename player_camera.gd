extends Camera3D
@onready var player_camera: Camera3D = $"."
@onready var player: CharacterBody3D = $"../Player"



@export_category("Settings")
@export var Change_Settings: bool = true
@export var set_fov: float = 14
@export var set_angle: float = -26
@export var set_height_y: float = 43
@export var set_distance_z: float = 87
@export var follow_player: bool = true



func _process(delta: float) -> void:
	## Camera Settings
	if (Change_Settings == true):
		player_camera.fov = set_fov
		player_camera.position = Vector3(0, set_height_y, set_distance_z)
		player_camera.rotation_degrees.x = set_angle
	if (follow_player == true):
		# Berechne den gewünschten Abstand basierend auf der Spielerposition
		var offset = Vector3(0, set_height_y, set_distance_z)
		# Setze die globale Position der Kamera relativ zum Spieler
		global_position = player.global_position + offset
		

		
		

	
