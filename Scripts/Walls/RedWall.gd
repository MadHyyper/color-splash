extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = false

func _on_player_change_color(color):
	if color == 2:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
