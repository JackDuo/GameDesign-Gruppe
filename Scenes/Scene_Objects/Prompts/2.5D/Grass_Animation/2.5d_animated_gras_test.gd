extends Area3D

# Referenz auf den AnimationPlayer (anpassen, falls er woanders liegt)
@onready var animation_player: AnimationPlayer = $Sprite3D/AnimationPlayer

func _ready() -> void:
	# Signal via Code verbinden (alternativ geht das auch über den Editor)
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node3D) -> void:
	# Optional: Prüfen, ob es wirklich der Spieler ist (z.B. über eine Gruppe)
	#if body.is_in_group("player"):
		# Animation abspielen (ersetze "deine_animation" mit dem echten Namen)
	animation_player.play("grass_collition_animation_test")
