extends MeshInstance3D


# liste de phrases
var textJuliette = ["hide",
				"hide",
				"Je t'aime !!!\n",
				"wait",
				"hide",
				"hide",
				"A quelle heure, demain ?\n",
				"wait",
				"hide",
				"hide",
				"Je n'y manquerais pas.\n",
				"wait",
				"hide",
				"hide",
				"Je l'oublierais...\n",
				"wait",
				"hide",
				"hide",
				"il est presque jour.\n",
				"wait",
				"hide",
				"hide",
				"Je voudrais aussi\n",

				]

var textRomeo = ["C'est mon âme qui me rappelle par mon nom !\n",
				"wait",
				"hide",
				"hide",
				"Ma mie ?\n",
				"wait",
				"hide",
				"hide",
				"A neuf heures.\n",
				"wait",
				"hide",
				"hide",
				"Laisse moi rester ici.\n",
				"wait",
				"hide",
				"hide",
				"Je resterai la.\n",
				"wait",
				"hide",
				"hide",
				"Je voudrais etre ton oiseau !\n",
				"wait",
				"hide",
				"hide",
				"Dors bien, mon amour.\n",
			]

var textConsierge = ["hide!\n",
				"hide",
				"hide",
				"hide",
				"hide\n",
				"De pain…",
				"wait",
				"hide",
				"hide",
				"Hey Joe !",
				"wait",
				"Tu te souviens de tes 14 balais ?",
				"wait\n",
				"hide",
				"hide",
				"hide",
				"A d’autres petit, ton smartphone connaît ton adresse.\n",
				"wait",
				"hide",
				"hide",
				"hide",
				"Canard !",
				"wait",
				"hide",
				"A diou Anna Maria bas pla ?!",
			]

var textAnna = ["hide",
				"hide",
				"hide",
				"hide",
				"hide",
				"hide",
				"hide",
				"hide",
				"hide",
				"Du soir j’espère, laisse les bonnes gens dormir en paix.",
				"wait",
				"hide",
				"hide",
				"hide",
				"Tais-toi Concierge, nous sommes ici pour Juliette et Roméo !",
				"wait",
				"Je resterai la.\n",
				"wait",
				"hide",
				"hide",
				"hide",
				"hide",
				"Coin coin !",
				"wait",
				"Pas de re*armement demographique svp",
			]

var texte = textRomeo

# Phrase courante
var num_phrase = 0

# etat de la bulle
var is_waiting= false
var start_waiting
var is_hidden = false
var start_hidden
var repeat_text=true # pour faire tourner le texte en boucle

var fin_texte

@onready var  label_3d=$Label3D

var moment # temps local
const delta_time = 0.01 # temps entre deux lettres

var fini: bool = false # lorsque tout le texte a été affiché
# Called when the node enters the scene tree for the first time.

func demarre_lecture():
	fin_texte=5
	moment=0
	num_phrase=0
	label_3d.text= texte[num_phrase].substr(0,5)+"..."



func _ready():
	if $".."["metadata/PlayerCharacter"] == 0 :
		texte = textJuliette
	if $".."["metadata/PlayerCharacter"] == 1 :
		texte = textRomeo
	if $".."["metadata/PlayerCharacter"] == 2 :
		texte = textConsierge
	if $".."["metadata/PlayerCharacter"] == 3 :
		texte = textAnna
	
	demarre_lecture()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fini:
		if repeat_text:
			demarre_lecture()
			fini=false
		return
	moment+=delta
	if is_hidden:
		if moment>start_hidden+2:
			is_hidden=false
			num_phrase+=1
			visible=true
		else:
			return
	
	elif is_waiting:
		if moment>start_waiting+2:
			is_waiting=false
			num_phrase+=1
		else:
			return

	
	if texte[num_phrase]=="hide":
			is_hidden=true
			start_hidden=moment
			visible=false
			
			return
	
	if texte[num_phrase]=="wait":
			is_waiting=true
			start_waiting=moment
			
			return
	
	if moment>delta_time: #il faut avancer d'une lettre
		var texte_courant=""
		moment=0
		if fin_texte<=len(texte[num_phrase])-1:
			fin_texte+=1
		elif num_phrase<len(texte)-1:
			num_phrase+=1
			fin_texte=0
		else:
			fini = true
		var i
		i=num_phrase-2
		if i<0:
			i=0
		while i<num_phrase:
			if texte[i]!="hide" and  texte[i]!="wait":
				texte_courant+=texte[i]
			i+=1
		texte_courant+=texte[num_phrase].substr(0,fin_texte)	
		label_3d.text=texte_courant
