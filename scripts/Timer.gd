extends Label

var time = 0
var stop : bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not stop:
		time += delta
		self.set_text(str(int(time)))

func white_text():
	self.set_modulate(Color(1,1,1,1))
	
func black_text():
	self.set_modulate(Color(0,0,0,1))

func stop_timer():
	stop = true
	
func start_timer():
	stop = false
