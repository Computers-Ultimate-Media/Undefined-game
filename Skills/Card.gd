extends TextureButton

var color
var title = "_title"
var point = "_point"

func _ready():
	$CardColor.color = Color.blueviolet
	$CardColor/CardName.text = title
	$CardColor/CardPoint.text = point

func _on_Card_pressed():
	print(self.title)
