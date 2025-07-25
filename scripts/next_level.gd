extends Area2D

const FILE_BEGIN = "res://levels/level_"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		animation_player.play("cut")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(next_level_path)
