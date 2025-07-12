extends Area2D

@export var slimer_speed : float = -100

var is_dead : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slimer_speed, 0) * delta
		
	if position.x < -267:
		queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over()
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		#直接引用动画注意不能更改他的名称
		$AnimatedSprite2D.play("death")
		is_dead = true
		area.queue_free()
		get_tree().current_scene.score += 1
		$AudioStreamPlayer.play()
		
		await get_tree().create_timer(0.6).timeout
		queue_free()
		
