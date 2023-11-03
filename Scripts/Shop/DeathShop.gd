extends Node2D

var timer = 5


func _on_Timer_timeout():
    if timer > 0:
        timer -=1
        $TimerLabel.text = "0:" + str(timer)
        $Timer.start()
    else:
        GameManager.deathdealer.quit_time()
        
