extends Panel


export(float, 0.1, 2, 0.1) var text_speed = 1

onready var dialog_label 		= $Margin/DialogText
onready var text_timer 			= $TextSpeed
onready var next_line_sprite 	= $NextLineSprite

enum states {
	WRITING,
	FINISHED
}

var current_state = states.WRITING

var current_text_line = 1
var test_text = [
	{"name": "lain",		"text": "lorem ipsum dolor inet"},
	{"name": "pistacho",	"text": "let's all love lain"},
	{"name": "lain", 		"text": "infornography"},
]

func _ready():
	dialog_label.text = test_text[current_text_line]["text"]
	dialog_label.visible_characters = 0
	text_timer.connect("timeout", self, "_on_text_timer_timeout")
	text_timer.wait_time = text_speed
	text_timer.start()


# func _process(delta):
# 	print(text_timer.time_left)

func set_text_speed(new_wait_timer):
	text_timer.wait_time = new_wait_timer

func _on_text_timer_timeout():
	if dialog_label.visible_characters >= dialog_label.text.length():
		text_timer.stop()
		current_state = states.FINISHED
		return

	dialog_label.visible_characters += 1
	text_timer.start()
