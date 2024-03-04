extends Node

@export var mob_scene: PackedScene
@export var berry_scene: PackedScene
var score
var screen_size



func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BerryTimer.stop()
	print(JSON.stringify(mobs))
	$HUD.show_game_over()
	$game_over.play()
	for n in get_children():
		if	n.name.begins_with("berry"):
			n.queue_free()
		if n.name.begins_with("mob"):
			var moblist= "Name: %s, Pos: %s, Dir: %s"
			var final= moblist % [n.name,n.position,n.rotation]
			print(final)
	
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_score_timer_timeout():
	$HUD.update_score(score)
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$BerryTimer.start()

var mobs = {}
var mobnumber = 0
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI/2
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI/4,PI/4)
	
	var velocity = Vector2(randf_range(150,250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	mob.rotation=direction
	
	var mobname ="mob" + str(mobnumber)
	mobs[mobname] = {
		"position": mob.position,
		"direction": mob.rotation,
	}
	
	score += .5
	mobnumber+=1
	add_child(mob)
	mob.name = "mob"

func _on_berry_timer_timeout():
	var berry = berry_scene.instantiate()
	var berry_spawn_location = Vector2(randf_range(0,480),randf_range(0,640))
	berry.position = berry_spawn_location
	add_child(berry)
	berry.name= "berry"


func _on_player_power():
	score += 10
	print("+10") # Replace with function body.
