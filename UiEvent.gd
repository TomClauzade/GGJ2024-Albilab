extends Container



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if VG.etat == VG.Etat.ecranTitre :
		$horloge.visible = false
		$StartPanel/TextureButton/Button.visible = true
		$StartPanel/TextureButton.visible = true
		$"../EndContainer/Perdant".visible = false
		$"../EndContainer/Gagant".visible = false
		if Input.is_action_just_pressed("ui_startButton") :
			print("Start")
			remove_child($StartPanel)
			VG.etat = VG.Etat.presentation
			VG.launchPresentation()
			
			
	elif VG.etat == VG.Etat.presentation :
			pass
			
	elif VG.etat == VG.Etat.selection :
		if Input.is_action_just_pressed("ui_startButton") :
			VG.etat = VG.Etat.inGame
			$horloge.visible = true
			$horloge.start()
			
	elif VG.etat == VG.Etat.inGame :
		if Input.is_action_just_pressed("ui_startButton") :
			print("poz")
			#get_tree().paused = true
			#Ecran de pose
		
			
			
	elif VG.etat == VG.Etat.inPoz :
		if Input.is_action_just_pressed("ui_startButton") :
			print("Unpoz")
			#get_tree().paused = false
			#Retour en Jeu
			
	
	elif VG.etat == VG.Etat.fin :
		if VG.nbPlayer > 0 :
			#UI gagant avec Nom
			print("Gagné !")
			$"../EndContainer/Gagant".visible = true
			$"../EndContainer/Perdant".visible = false
			for i in VG.liste_joueurs:
				if i == VG.Choix.Juliette :
					$"../EndContainer/Gagant/Juliette".visible = true
				if i == VG.Choix.Romeo :
					$"../EndContainer/Gagant/Romeo".visible = true
				if i == VG.Choix.Joueur3 :
					$"../EndContainer/Gagant/Consierge".visible = true
				if i == VG.Choix.Joueur4 :
					$"../EndContainer/Gagant/Anna".visible = true
			
		else :
			$"../EndContainer/Perdant".visible = true
			$"../EndContainer/Gagant".visible = false



