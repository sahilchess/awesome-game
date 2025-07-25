extends Area2D
@onready var timer: Timer = $Timer
@onready var explosion: AudioStreamPlayer = $explosion

signal death

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	explosion.play()
	Engine.time_scale = 0.5
	ScoreCounter.score = 0
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("CollisionShape2D2").queue_free()
	emit_signal("death")
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
