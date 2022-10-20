extends Node2D

func _on_ZonaApi_body_entered(body):
	if body.name == 'Hero':
		get_tree().change_scene("res://Level1.tscn")
