extends Area2D
class_name HitBox

@export_enum("null","invincility","wounded") var effect:String = "null"
##Number of seconds added
@export var effect_strenght:int = 20
@export var damage:int = 20

var hit_reg:bool = false
var hurtboxes_hit:Array[HurtBox] = []

func _ready():
	connect("area_entered",area_entered)

func area_entered(area:Area2D):
	if hit_reg:
		if not (area in hurtboxes_hit):
			if area is HurtBox:
				hit_hurtbox(area)
				hurtboxes_hit.append(area)

func open_hit():
	hit_reg = true
	hurtboxes_hit = []

func close_hit():
	hit_reg = false
	hurtboxes_hit = []

func instant_hit():
	for node in get_overlapping_areas():
		if node is HurtBox:
			hit_hurtbox(node)
			

func hit_hurtbox(box:HurtBox):
	box.health_component.add_damage(damage)
	box.health_component.add_effect(effect,effect_strenght/100)
