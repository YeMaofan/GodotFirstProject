extends CharacterBody2D

@export var move_speed : float = 50
@export var animator : AnimatedSprite2D
@export var bullet_scene : PackedScene
# Called when the node enters the scene tree for the first time.

var isgame_over : bool = false

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or isgame_over:
		$RunningSound.stop()
	elif not $RunningSound.playing:
		$RunningSound.play()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not isgame_over:
		isgame_over = false
		velocity = Input.get_vector("left", "right", "up", "down") * move_speed
		
		# 如果速度为0，播放待机动画
		if velocity == Vector2.ZERO: 
			animator.play("idle")
		# 如果速度不为0，播放跑步动画
		else:
			animator.play("run")
		move_and_slide()
	
func game_over():
	if not isgame_over:
		isgame_over = true
		animator.play("gameover")
		
		get_tree().current_scene.show_gameover()
		$gameover.play()
		
		await get_tree().create_timer(3).timeout
		$RestartTime.start()
		

func _on_fire() -> void:
	if velocity != Vector2.ZERO or isgame_over == true:
		return
		
	$AudioStreamPlayer.play()
	
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2( 6, 6)
	get_tree().current_scene.add_child(bullet_node)
	

func _reload_scene() -> void:
	get_tree().reload_current_scene()
