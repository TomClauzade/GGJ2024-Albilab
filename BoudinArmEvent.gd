extends StaticBody3D

var _Dir = 1
var _RotSpeed = 1
# Called when the node enters the scene tree for the first time.
enum Etat { isTurning, isWaitingStop, isStopped}
var etat:Etat= Etat.isStopped

func _ready():
	etat=Etat.isStopped
	pass # Replace with function body.

func startTurning():
	etat=Etat.isTurning

func stopTurning():
	etat=Etat.isWaitingStop
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if etat==Etat.isTurning :
			self.rotation.z += _RotSpeed * delta *_Dir
	
	elif etat==Etat.isWaitingStop:
		self.rotation.z += _RotSpeed * delta *_Dir
		if abs(abs(int(self.rotation.z/3.14*180)) % 360-90) <=0.01:
			etat=Etat.isStopped
	
	elif etat==Etat.isStopped:
		pass
	else:
		print("erreur Boudin")
	
	
	

	
	

