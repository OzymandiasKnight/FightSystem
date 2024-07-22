extends Area2D
class_name HurtBox


signal damage_taken(damage:int)
signal damage_blocked(damage:int)
signal healed(heal:int)
signal died()
signal revived()
signal effect_applied(effect_name:String,time_left:float)

@export var health_component:HealthComponent

func _ready():
	health_component.hurtbox = self
