extends Area2D

func _ready():
	$Berry.animation = "default"
	$Berry.play()
	
func _on_area_entered(area):
	print("entered")
	area.power_up()
	queue_free()
	


func _on_timer_timeout():
	queue_free()
