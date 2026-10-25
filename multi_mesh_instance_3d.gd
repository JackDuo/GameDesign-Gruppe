extends MultiMeshInstance3D

func _ready():
	var breite = 10 # Wie viele Quadrate in einer Reihe
	var groesse = 2.0 # Die Kantenlänge Ihrer PlaneMesh

	for i in multimesh.instance_count:
		var x = i % breite
		var z = i / breite
		
		# Position für jedes Quadrat berechnen
		var pos = Transform3D()
		pos = pos.translated(Vector3(x * groesse, 0, z * groesse))
		
		# Quadrat an der Position platzieren
		multimesh.set_instance_transform(i, pos)
