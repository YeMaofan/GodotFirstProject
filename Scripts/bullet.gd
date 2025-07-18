extends Area2D

@export var bullet_speed: float = 200

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(bullet_speed, 0) * delta
