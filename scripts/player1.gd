extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Floor.new(Player.new(Vector2i(0,0)))
