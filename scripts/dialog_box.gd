extends Panel


export(float, 0.1, 2, 0.1) var text_speed = 1.0

onready var dialog_label 		= $Margin/DialogText
onready var text_timer 			= $TextSpeed
onready var next_line_sprite 	= $NextLineSprite

enum states {
	WRITING,
	WAITING,
	FINISHED
}

var current_state = states.WRITING

var current_text_line = 0
# TODO: Obtener el diccionario de un archivo externo (.json)
# TODO: Hacer que el sprite parpadee
# TODO: Hacer que el sprite sea diferente cuando sea el ultimo texto en el diccionario
var test_text = [
	{"name": "lain",		"text": "lorem ipsum dolor inet"},
	{"name": "pistacho",	"text": "let's all love lain"	},
	{"name": "lain", 		"text": "infornography"			},
]

func _ready():
	dialog_label.text = test_text[current_text_line]["text"]
	dialog_label.visible_characters = 0

	text_timer.connect("timeout", self, "_on_text_timer_timeout")
	text_timer.wait_time = text_speed
	text_timer.start()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if current_state == states.WRITING:
			dialog_label.visible_characters = dialog_label.text.length()
			return
			
		if current_text_line >= test_text.size()-1:
			queue_free()
			return

		get_new_line()

func get_new_line():
	current_text_line += 1
	dialog_label.visible_characters = 0
	dialog_label.text = test_text[current_text_line]["text"]
	current_state = states.WRITING
	text_timer.start()


func _on_text_timer_timeout():
	if dialog_label.visible_characters >= dialog_label.text.length():
		text_timer.stop()
		current_state = states.WAITING
		return

	dialog_label.visible_characters += 1
	text_timer.start()
