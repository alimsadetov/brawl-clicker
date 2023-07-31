extends TextureButton

signal changeGirl

func _ready():
	texture_normal = Global.currentGirl.base
	texture_pressed = Global.currentGirl.base



func _on_character_pressed():
	$"../AudioStreamPlayer2D".stream = load("res://1.wav")
	$"../AudioStreamPlayer2D".play() 
	get_node("AnimationPlayer").play("scale")
	
	Global.Score+=Global.CurrentMultiplicator
	get_node("../Control").update_score()
	yield(get_tree().create_timer(0.7), "timeout")
	Global.save()


func _on_character_changeGirl():
	texture_normal = Global.currentGirl.base
	texture_pressed = Global.currentGirl.base
