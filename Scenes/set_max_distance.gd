extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
# sonst sind die Schatten nicht sichtbar, weil die Kamera/das licht zu weit weg sind. Höherer Wert intensiviert den Schatten
func _ready() -> void:
	directional_shadow_max_distance = 200
