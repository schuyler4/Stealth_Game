
extends Sprite
var speed = 3
var playerSeen = false

var box1 = null
var box2 = null

var vistionBox1 
var vistionBox2

var vistionField

func _ready():
	box1 = RectangleShape2D.new()
	box2 = RectangleShape2D.new()
	
	vistionBox1 = RectangleShape2D.new()
	vistionBox2 = RectangleShape2D.new()
	
	vistionField = get_node("visionRange")	
	var visionPosition = vistionField.get_pos()
	var visionRotation = vistionField.get_rot()
	
	set_process(true)
	
func _process(delta):
	var position = self.get_pos()
	var rotation = self.get_rot()
	var playerPosition  = get_node("/root/Scene/Player").get_pos()
	var sprite2 = get_node("/root/Scene/Player")
	
	if(!playerSeen):
		rotation += 0.1 * delta
	else:
		if(playerPosition.x > position.x):
			position.x += speed
			rotation += 1
		elif(playerPosition.x < position.x):
			position.x -= speed
			rotation -= 1
		if(playerPosition.y < position.y):
			position.y -= speed 
			rotation -= 1
		elif(playerPosition.y > position.y):
			position.y += speed 
			rotation += 1
			
	box1.set_extents(Vector2(self.get_texture().get_size().width/2,self.get_texture().get_size().height/2))
	box2.set_extents(Vector2(sprite2.get_texture().get_size().width/2,sprite2.get_texture().get_size().height/2))
	
	vistionBox1.set_extents(Vector2(vistionField.get_texture().get_size().width/2,vistionField.get_texture().get_size().height/2))
	vistionBox2.set_extents(Vector2(sprite2.get_texture().get_size().width/2,sprite2.get_texture().get_size().height/2))
		
	if(box1.collide(get_transform(),box2,sprite2.get_transform())):
    	get_tree().change_scene("res://Scenes/gameOver.scn")

	if(vistionBox1.collide(get_transform(),vistionBox2,sprite2.get_transform())):
		playerSeen = true
		
	self.set_pos(position)
	self.set_rot(rotation)
	