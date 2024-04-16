extends StaticBody3D


var _platformRotSpeed = 01
var _platformAngleMax = 3.14/180*40
var _platDir = 1
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
		if abs(self.rotation.z) < _platformAngleMax :
			self.rotation.z += _platformRotSpeed * delta *_platDir
		else :
			self.rotation.z = _platformAngleMax* _platDir*0.99
			_platDir = -_platDir
	
	elif etat==Etat.isWaitingStop:
		
		if abs(self.rotation.z) < _platformAngleMax :
			self.rotation.z += _platformRotSpeed * delta *_platDir
		else :
			self.rotation.z = _platformAngleMax* _platDir*0.99
			_platDir = -_platDir
		if abs(self.rotation.z)<=0.01:
			etat=Etat.isStopped
	
	elif etat==Etat.isStopped:
		pass
	else:
		print('erreur platform')
	
	
	

	
	

