extends Node

const FILE_NAME = "user://game-data.json"
var Score = 0
var Stars = 0

var CurrentMultiplicator = 1
var CurrentStarPrice = 200

var CurrentMultiplicatorPrice = CurrentMultiplicator * 200 - (CurrentMultiplicator*30)

var current_gallery_page = 1
var current_instance_girl1
var current_instance_girl2
var current_instance_girl3

var CurrentBackId = 1

var CurrentTrack = 1

var isMusic = false

var callback_rewarded_ad = JavaScript.create_callback(self, '_rewarded_ad')
var callback_ad = JavaScript.create_callback(self, '_ad')
onready var win = JavaScript.get_interface("window")




var girl1ten = preload("res://girl1/ten.png")
var girl2ten = preload("res://girl2/ten.png")
var girl3ten = preload("res://girl3/ten.png")
var girl4ten = preload("res://girl4/ten.png")
var girl5ten = preload("res://girl5/ten.png")
var girl6ten = preload("res://girl6/ten.png")
var girl7ten = preload("res://girl7/ten.png")
var girl8ten = preload("res://girl8/ten.png")
var girl9ten = preload("res://girl9/ten.png")
var girl10ten = preload("res://girl10/ten.png")
var girl11ten = preload("res://girl11/ten.png")
var girl12ten = preload("res://girl12/ten.png")
var girl13ten= preload("res://girl13/ten.png")
var girl14ten = preload("res://girl14/ten.png")
var girl15ten = preload("res://girl15/ten.png")
var girl16ten= preload("res://girl16/ten.png")
var girl17ten = preload("res://girl17/ten.png")
var girl18ten = preload("res://girl18/ten.png")

var girl1base = preload("res://girl1/base.png")
var girl2base = preload("res://girl2/base.png")
var girl3base = preload("res://girl3/base.png")
var girl4base = preload("res://girl4/base.png")
var girl5base = preload("res://girl5/base.png")
var girl6base = preload("res://girl6/base.png")
var girl7base = preload("res://girl7/base.png")
var girl8base = preload("res://girl8/base.png")
var girl9base = preload("res://girl9/base.png")
var girl10base = preload("res://girl10/base.png")
var girl11base = preload("res://girl11/base.png")
var girl12base = preload("res://girl12/base.png")
var girl13base = preload("res://girl13/base.png")
var girl14base = preload("res://girl14/base.png")
var girl15base = preload("res://girl15/base.png")
var girl16base = preload("res://girl16/base.png")
var girl17base = preload("res://girl17/base.png")
var girl18base = preload("res://girl18/base.png")


var girl1 = {"id": 1, "reached": false, "status": "simple", "base": girl1base, "ten": girl1ten}
var girl2 = {"id": 2, "reached": false, "status": "simple", "base": girl2base, "ten": girl2ten}
var girl3 = {"id": 3, "reached": false, "status": "simple", "base": girl3base, "ten": girl3ten}
var girl4 = {"id": 4, "reached": false, "status": "simple", "base": girl4base, "ten": girl4ten}
var girl5 = {"id": 5, "reached": false, "status": "simple", "base": girl5base, "ten": girl5ten}
var girl6 = {"id": 6, "reached": false, "status": "rare", "base": girl6base, "ten": girl6ten}
var girl7 = {"id": 7, "reached": false, "status": "simple", "base": girl7base, "ten": girl7ten}
var girl8 = {"id": 8, "reached": false, "status": "simple", "base": girl8base, "ten": girl8ten}
var girl9 = {"id": 9, "reached": false, "status": "rare", "base": girl9base, "ten": girl9ten}
var girl10 = {"id": 10, "reached": false, "status": "simple", "base": girl10base, "ten": girl10ten}
var girl11 = {"id": 11, "reached": false, "status": "rare", "base": girl11base, "ten": girl11ten}
var girl12 = {"id": 12, "reached": false, "status": "simple", "base": girl12base, "ten": girl12ten}
var girl13 = {"id": 13, "reached": false, "status": "simple", "base": girl13base, "ten": girl13ten}
var girl14 = {"id": 14, "reached": false, "status": "rare", "base": girl14base, "ten": girl14ten}
var girl15 = {"id": 15, "reached": true, "status": "simple", "base": girl15base, "ten": girl15ten}
var girl16 = {"id": 16, "reached": false, "status": "simple", "base": girl16base, "ten": girl16ten}
var girl17 = {"id": 17, "reached": false, "status": "rare", "base": girl17base, "ten": girl17ten}
var girl18 = {"id": 18, "reached": false, "status": "rare", "base": girl18base, "ten": girl18ten}

var currentGirl = girl15

#var currentGirlSprBase = girl15base
#var currentGirlSprBlush = girl15blush

func _ready():
	AudioServer.set_bus_mute(0, false)
	js_show_ad()
	Global.load()
	TranslationServer.set_locale(win.GetLang())
	if win.GetLang()==null:
		TranslationServer.set_locale("ru")
	
	
	

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN: AudioServer.set_bus_mute(0, false)
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT: AudioServer.set_bus_mute(0, true)

func js_show_ad():
	win.ShowAd(callback_ad)
	pass
# Здесь можно приостановить музыку / звуки
func js_show_rewarded_ad():
	#AudioServer.set_bus_mute(0, true)
	win.ShowAdRewardedVideo(callback_rewarded_ad)
# Здесь можно приостановить музыку / звуки
func _rewarded_ad(args):
	CurrentMultiplicator+=3
	CurrentMultiplicatorPrice = CurrentMultiplicator * 200 - (CurrentMultiplicator*30)
	get_node("/root/Main/actions").update_multiplicator_label()
	save()
	#AudioServer.set_bus_mute(0, false)
# Здесь можно возобновить музыку / звуки
func _ad(args):
	print(args[0])
	#AudioServer.set_bus_mute(0, false)
# Здесь можно возобновить музыку / звуки

func save():
	var file = File.new()
	var saveJson = {
		"score": Global.Score,
		"stars": Global.Stars,
		"currentMultiplicator": Global.CurrentMultiplicator,
		"currentStarPrice": Global.CurrentStarPrice,
		"currentBackId": Global.CurrentBackId,
		"girl1": Global.girl1.reached,
		"girl2": Global.girl2.reached,
		"girl3": Global.girl3.reached,
		"girl4": Global.girl4.reached,
		"girl5": Global.girl5.reached,
		"girl6": Global.girl6.reached,
		"girl7": Global.girl7.reached,
		"girl8": Global.girl8.reached,
		"girl9": Global.girl9.reached,
		"girl10": Global.girl10.reached,
		"girl11": Global.girl11.reached,
		"girl12": Global.girl12.reached,
		"girl13": Global.girl13.reached,
		"girl14": Global.girl14.reached,
		"girl15": Global.girl15.reached,
		"girl16": Global.girl16.reached,
		"girl17": Global.girl17.reached,
		"girl18": Global.girl18.reached,
		"currentGirlId": Global.currentGirl.id
	}
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(saveJson))
	file.close()

func load():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		Score = data.score
		Stars = data.stars
		if (data.stars<0):
			Stars = 0
		CurrentMultiplicator = data.currentMultiplicator
		CurrentMultiplicatorPrice = CurrentMultiplicator * 200 - (CurrentMultiplicator*30)
		CurrentStarPrice = data.currentStarPrice
		if (data.has("currentBackId")):
			CurrentBackId=data.currentBackId
		girl1.reached = data.girl1
		girl2.reached = data.girl2
		girl3.reached = data.girl3
		girl4.reached = data.girl4
		girl5.reached = data.girl5
		girl6.reached = data.girl6
		girl7.reached = data.girl7
		girl8.reached = data.girl8
		girl9.reached = data.girl9
		girl10.reached = data.girl10
		girl11.reached = data.girl11
		girl12.reached = data.girl12
		girl13.reached = data.girl13
		girl14.reached = data.girl14
		girl15.reached = data.girl15
		girl16.reached = data.girl16
		girl17.reached = data.girl17
		girl18.reached = data.girl18
		setCurrentGirl(data.currentGirlId)
		file.close()
	else:
		print("No saved data!")
		
func setCurrentGirl(currentGirlId):
	if (currentGirlId==1):
		currentGirl = girl1
	if (currentGirlId==2):
		currentGirl = girl2
	if (currentGirlId==3):
		currentGirl = girl3
	if (currentGirlId==4):
		currentGirl = girl4
	if (currentGirlId==5):
		currentGirl = girl5
	if (currentGirlId==6):
		currentGirl = girl6
	if (currentGirlId==7):
		currentGirl = girl7
	if (currentGirlId==8):
		currentGirl = girl8
	if (currentGirlId==9):
		currentGirl = girl9
	if (currentGirlId==10):
		currentGirl = girl10
	if (currentGirlId==11):
		currentGirl = girl11
	if (currentGirlId==12):
		currentGirl = girl12
	if (currentGirlId==13):
		currentGirl = girl13
	if (currentGirlId==14):
		currentGirl = girl14
	if (currentGirlId==15):
		currentGirl = girl15
	if (currentGirlId==16):
		currentGirl = girl16
	if (currentGirlId==17):
		currentGirl = girl17
	if (currentGirlId==18):
		currentGirl = girl18
