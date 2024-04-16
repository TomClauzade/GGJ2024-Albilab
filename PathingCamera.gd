extends PathFollow3D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var changeTime = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_children()[0].current == true :
		progress_ratio += 0.1 * delta
		changeTime += delta
		
	if progress_ratio >= 1 or changeTime >= 7 :
		print("Change Camera")
		changeTime = 0
		_ChangeCamera()
	pass


func _ChangeCamera():
	progress_ratio = 0
	VG.listActiveCameras[VG.prevCam].current = false
 
	var newCam = randi() % VG.listActiveCameras.size()
	while newCam == VG.prevCam :
		newCam = randi() % VG.listActiveCameras.size()
	VG.prevCam = newCam
	VG.listActiveCameras[newCam].current = true
	VG.listActiveCameras[newCam].get_parent().progress_ratio = 0
	pass
	
