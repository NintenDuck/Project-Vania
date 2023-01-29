extends Panel


export(float, 0.1, 2, 0.1) var text_speed = 1.0
export(String,FILE) var dialogue_fpath = "res://json/test.json"

onready var dialog_label 		= $Margin/DialogText
onready var text_timer 			= $TextSpeed
onready var next_line_sprite 	= $NextLineSprite
onready var next_line_animation	= $NextLineSprite/AnimationPlayer

enum states {
	WRITING,
	WAITING,
	FINISHED
}

var dialogue = []
var current_state = states.WRITING
var current_text_line = 0

# TODO: Hacer que el sprite sea diferente cuando sea el ultimo texto en el diccionario

func _ready():
	dialogue = JsonManager.json_as_dict(dialogue_fpath)
	dialog_label.text = dialogue[current_text_line]["text"]
	dialog_label.visible_characters = 0

	next_line_sprite.visible = false

	text_timer.connect("timeout", self, "_on_text_timer_timeout")
	text_timer.wait_time = text_speed
	text_timer.start()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if current_state == states.WRITING:
			dialog_label.visible_characters = dialog_label.text.length()
			return
			
		if current_text_line >= dialogue.size()-1:
			queue_free()
			return

		next_line_animation.stop()
		next_line_sprite.visible = false
		get_next_line()


func get_next_line():
	current_text_line += 1
	dialog_label.visible_characters = 0
	dialog_label.text = dialogue[current_text_line]["text"]
	current_state = states.WRITING
	text_timer.start()

func _on_text_timer_timeout():
	if dialog_label.visible_characters >= dialog_label.text.length():
		text_timer.stop()
		current_state = states.WAITING
		next_line_animation.play("regular_text")
		
		next_line_sprite.visible = true

		if dialogue.size()-1 <= current_text_line:
			current_state = states.FINISHED
			next_line_animation.play("final_text")

		return

	dialog_label.visible_characters += 1
	text_timer.start()
