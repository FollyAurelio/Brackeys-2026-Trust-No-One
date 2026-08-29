@abstract class_name Enemy
extends Thing

#health?
#power?

func _to_string() -> String:
	return "E"

func after_player_turn(flor : Floor) -> void:
	var player = flor.get_player()
	if player.position == position:
		player.move_back(flor)
		#take 1 damage
