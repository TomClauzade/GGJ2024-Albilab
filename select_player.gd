extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var nb_joueur_tempo = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_startButton") :
		_on_button_pressed()
		
	if VG.choix==VG.Choix.Juliette:
		for c in VG.liste_controleur:
			if Input.is_action_just_pressed(c) :
				print("input juliette detected")
				$s_Juliette.visible = true
				nb_joueur_tempo+=1
				VG.controleur[VG.choix]=c
				VG.liste_controleur.erase(c)
				print(VG.liste_controleur)
				VG.choix=VG.Choix.Romeo
				VG.liste_joueurs.append(VG.Choix.Juliette)
				$Label_choix.text="Activer la manette de Roméo" 
				
	if VG.choix==VG.Choix.Romeo:
		for c in VG.liste_controleur:
			if Input.is_action_just_pressed(c) :
				print("input romeo detected")
				$s_Romeo.visible = true
				nb_joueur_tempo+=1
				VG.controleur[VG.choix]=c
				VG.liste_controleur.erase(c)
				print(VG.liste_controleur)
				VG.choix=VG.Choix.Joueur3
				VG.liste_joueurs.append(VG.Choix.Romeo)
				$Label_choix.text="Activer la manette du joueur3" 
				
	if VG.choix==VG.Choix.Joueur3:
		for c in VG.liste_controleur:
			if Input.is_action_just_pressed(c) :
				print("input Joueur3 detected")
				$s_player_3.visible = true
				nb_joueur_tempo+=1
				VG.controleur[VG.choix]=c
				VG.liste_controleur.erase(c)
				VG.choix=VG.Choix.Joueur4
				$Label_choix.text="Activer la manette du joueur4" 
				VG.liste_joueurs.append(VG.Choix.Joueur3)
				
	if VG.choix==VG.Choix.Joueur4:
		for c in VG.liste_controleur:
			if Input.is_action_just_pressed(c) :
				print("input joueur 4 detected")
				$s_player_4.visible = true
				nb_joueur_tempo+=1
				VG.controleur[VG.choix]=c
				VG.liste_controleur.erase(c)
				$Label_choix.text="Activer la manette de Juliette" 
				VG.liste_joueurs.append(VG.Choix.Joueur4)
				
	







func _on_gui_input(event):
	pass

func _on_button_pressed():
	VG.nbPlayer = nb_joueur_tempo
	VG.launchParty()
	$"..".remove_child(self)
	print("valider:",VG.controleur)
	pass # Replace with function body.


func _on_tree_entered():
	$Label_choix.text="Activer la manette de Juliette" 
	pass # Replace with function body.
