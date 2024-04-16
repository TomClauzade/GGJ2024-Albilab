extends Node

enum Etat {ecranTitre, presentation, selection, inGame, inPoz, fin}
var etat : Etat = Etat.ecranTitre

@onready var starters = [$"/root/Node3D/PlayerStarter/StartPlayer_1",
						$"/root/Node3D/PlayerStarter/StartPlayer_2",
						$"/root/Node3D/PlayerStarter/StartPlayer_3",
						$"/root/Node3D/PlayerStarter/StartPlayer_4"]
signal fin
var nbPlayer = 0
var prevCam = 0
var scaleDifficulty = 1.2
var tempsGlobalParty = 120

@onready var listCameraCine  = [$/root/Node3D/Scene/Camera/CinematicCamera/Side_Front2/PathFollow3D/CameraFront,
					$/root/Node3D/Scene/Camera/CinematicCamera/Face_Public/PathFollow3D/CameraFacePublic,
					$/root/Node3D/Scene/Camera/CinematicCamera/Forward2/PathFollow3D/CameraLooping]
					
@onready var listCameraInGame = [$/root/Node3D/Scene/Camera/InGameCamera/Path3D_Static/PathFollow3D/StaticCamera,
								$/root/Node3D/Scene/Camera/InGameCamera/Side_Front/PathFollow3D/CameraFront,
								$/root/Node3D/Scene/Camera/InGameCamera/Forward/PathFollow3D/CameraFor,
								$/root/Node3D/Scene/Camera/InGameCamera/Path3D_StaticAngle/PathFollow3D/StaticCameraAngle]
					
@onready var listActiveCameras = listCameraCine

@onready var activeEvent = false

var liste_joueurs=[]

var liste_evenement=[
	{"realized":false,"time":5,"func":"startPlat"},
	{"realized":false,"time":5,"func":"startBou"},
	{"realized":false,"time":10,"func":"stopPlat"},
	{"realized":false,"time":10,"func":"stopBou"},
	
	{"realized":false,"time":20,"func":"startPlat"},
	{"realized":false,"time":20,"func":"startBou"},
	{"realized":false,"time":30,"func":"stopPlat"},
	{"realized":false,"time":30,"func":"stopBou"},
	
	
	{"realized":false,"time":35,"func":"startPlat"},
	{"realized":false,"time":35,"func":"startBou"},
	{"realized":false,"time":50,"func":"stopPlat"},
	{"realized":false,"time":50,"func":"stopBou"},
]


var temps:float
# Called when the node enters the scene tree for the first time.
func _ready():
	temps=0
	pass # Replace with function body.

func startPlat():
	print('Plateau qui bouge')
	
	$"/root/Node3D/Planches/Planche(StaticBody3D)".startTurning()
	$"/root/Node3D/Planches/Planche(StaticBody3D)"._platformRotSpeed *= scaleDifficulty
	$"/root/Node3D/Planches/Planche(StaticBody3D)"._platformAngleMax *= scaleDifficulty

func stopPlat():
	print("stopPlat")
	$"/root/Node3D/Planches/Planche(StaticBody3D)".stopTurning()

func startBou():
	var l = [-1,1]
	$"/root/Node3D/Planches/BoudinArm"._Dir = l[randi() %2]
	$"/root/Node3D/Planches/BoudinArm"._RotSpeed *= scaleDifficulty
	$"/root/Node3D/Planches/BoudinArm".startTurning()

func stopBou():
	print("stopBou")
	$"/root/Node3D/Planches/BoudinArm".stopTurning()

func ecranTitre(n):
	$HUD/Panel.visible = false
	pass
	
var scene = preload("res://select_player.tscn").instantiate()
func select_nb_joueurs(n):
	etat = Etat.selection
	var tween = get_tree().create_tween()
	scene.position = Vector2(0,500)
	scene.visible = true
	get_tree().get_root().add_child(scene)
	tween.tween_property(scene, "position", Vector2(0, 0), 0.2)
# function appelée par le présentateur pour sélectionner le nombre de joueurs

func launchPresentation():
	Dialogic.start("res://presentateur/timelinePresentateur.dtl")


func launchParty ():
	#camera
	for c in listCameraCine :
		c.current = false
	listActiveCameras = listCameraInGame
	listActiveCameras[0].current = true
	#instantiation Joueurs
	instanciationJoueurs()
	initEvent()
	startEvent()
	$/root/Node3D/HUD/Container/horloge.start()
	
func endParty ():
	print("fin")
	$/root/Node3D/HUD/Container.visible = false
	$/root/Node3D/HUD/EndContainer.visible = true
	stopBou()
	stopPlat()
	etat = Etat.fin
	activeEvent = false
	pass
	
func initEvent ():
	temps = 0
	for e in liste_evenement:
		e["realized"]=false 

func startEvent ():
	activeEvent = true

func instanciationJoueurs():
	for i in range(nbPlayer):
		var playerInstance = preload("res://Player/Player.tscn").instantiate()
		playerInstance["metadata/PlayerCharacter"] = i
		starters[i].add_child.call_deferred(playerInstance)
		playerInstance.position = Vector3.ZERO
	pass

func verifMortJoueur():
	if nbPlayer == 0:
		#Si tout les jouers sont morts
		etat = Etat.fin
		endParty()
	

# gestionnaire d'évènements
func _process(delta):
	if activeEvent :
		temps+=delta
		for e in liste_evenement:
			if not e["realized"]:
				if temps>=e["time"]:
					call(e["func"])
					e["realized"]=true

enum Choix {Juliette=0, Romeo=1, Joueur3=2,Joueur4=3}
var choix:Choix=Choix.Juliette
var controleur={}
var liste_controleur=["ui_accept0","ui_accept1","ui_accept2","ui_accept3"]
var _dir0 = ["ui_left0","ui_right0","ui_up0","ui_down0"]
var _dir1 = ["ui_left1","ui_right1","ui_up1","ui_down1"]
var _dir2 = ["ui_left2","ui_right2","ui_up2","ui_down2"]
var _dir3 = ["ui_left3","ui_right3","ui_up3","ui_down3"]
var liste_Dir = [_dir0,_dir1,_dir2,_dir3]



