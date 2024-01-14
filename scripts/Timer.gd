extends Label

var time = 0
var stop : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not stop:
		time += delta
		self.set_text(str(int(time)))

func stop_timer():
	stop = true
