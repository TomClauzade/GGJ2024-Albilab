extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if self.position.y <= -2:
		print("c'est la mort")
		$"/root/Node3D/AudioLaugh".play()
		$"..".remove_child.call_deferred(self)
		VG.liste_joueurs.erase(self["metadata/PlayerCharacter"])
		VG.nbPlayer-=1

		VG.verifMortJoueur()
		
	# Player Controller N 0
	var numero = self["metadata/PlayerCharacter"]
	var n_controleur = int(VG.controleur[numero].substr( len(VG.controleur[numero])-1,len(VG.controleur[numero])))
	var _slideCollision = get_last_slide_collision()
	if Input.is_action_just_pressed(VG.controleur[numero]) and (is_on_floor() or _slideCollision != null):
		velocity.y = JUMP_VELOCITY
		_slideCollision = null
	
	var input_dir = Input.get_vector(VG.liste_Dir[n_controleur][0],
									VG.liste_Dir[n_controleur][1],
									VG.liste_Dir[n_controleur][2],
									VG.liste_Dir[n_controleur][3])
	#print ("ui_left"+str(self["metadata/PlayerCharacter"]))
	var _direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if _direction:
		velocity.x = _direction.x * SPEED
		velocity.z = _direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
			
			
	#Set animation
	if velocity.x <0:
		$RomeoAnimatedSprite3D.flip_h=false
		$JulietteAnimatedSprite3D.flip_h=false
		$ConsiergeAnimatedSprite3D2.flip_h=false
		$AnnaAnimatedSprite3D3.flip_h=false
	if velocity.x > 0 :
		$RomeoAnimatedSprite3D.flip_h=true
		$JulietteAnimatedSprite3D.flip_h=true
		$ConsiergeAnimatedSprite3D2.flip_h=true
		$AnnaAnimatedSprite3D3.flip_h=true
	if velocity.x != 0 :
		$RomeoAnimatedSprite3D._playRun()
		$JulietteAnimatedSprite3D._playRun()
		$ConsiergeAnimatedSprite3D2._playRun()
		$AnnaAnimatedSprite3D3._playRun()
	else:
		$RomeoAnimatedSprite3D._playIdle()
		$JulietteAnimatedSprite3D._playIdle()
		$ConsiergeAnimatedSprite3D2._playIdle()
		$AnnaAnimatedSprite3D3._playIdle()
		
	move_and_slide()


func _on_tree_entered():
	if self.get_meta("PlayerCharacter") == 0 :
		$JulietteAnimatedSprite3D.visible = true
	if self.get_meta("PlayerCharacter") == 1 :
		$RomeoAnimatedSprite3D.visible = true
	if self.get_meta("PlayerCharacter") == 2 :
		$ConsiergeAnimatedSprite3D2.visible = true
	if self.get_meta("PlayerCharacter") == 3 :
		$AnnaAnimatedSprite3D3.visible = true
	pass # Replace with function body.
