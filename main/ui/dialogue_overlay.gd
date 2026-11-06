class_name DialogueOverlay extends Overlay


signal dialogue_closed


@export var dialogue_speaker_label: Label

@export var dialogue_text_label: RichTextLabel

@export var speaker_texture_rect: TextureRect

@export var end_dialogue_button: Button

@export var next_button: Button





func _ready() -> void:

	end_dialogue_button.pressed.connect(_on_end_dialogue_pressed)




func set_speaker_name(_name: String) -> void:

	dialogue_speaker_label.text = _name



func set_speaker_texture(texture: Texture2D) -> void:

	speaker_texture_rect.texture = texture



func set_dialogue_text(text: String) -> void:

	dialogue_text_label.text = text







func _on_end_dialogue_pressed() -> void:

	close_requested.emit()

	dialogue_closed.emit()