extends AnimatedSprite2D

var temps = 0

enum  Etat {idle,avance,secousse}
var etat:Etat
var temps_écoulé=false
var début_secousses
var debut_avance=0

var lecteur = AudioStreamPlayer.new()
var sonnerie = load("res://horloge/alarme_incendie.wav")

func start():
	frame=0
	etat=Etat.avance

func _ready():
	
	lecteur.stream=sonnerie
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	temps+=delta
	if etat==Etat.avance:
		if temps>=debut_avance+VG.tempsGlobalParty/12:
			debut_avance=temps
			frame+=1
			if frame>=11:
				temps_écoulé=true
				etat=Etat.secousse
				début_secousses = temps
				self.add_child(lecteur)
				#lecteur.play()
				VG.endParty()
	elif etat==Etat.secousse:
		if temps<=début_secousses+5:
			self.rotation+=3.14/180*10*sin(2*3.14/0.5*temps)
		else:
			etat=Etat.idle
			lecteur.stop()
			remove_child(lecteur)
	elif etat==Etat.idle:
		
		pass
	else:
		print('erreur etat')
		
