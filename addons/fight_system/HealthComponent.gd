extends Node
class_name HealthComponent

##Entity Health
@export var health:int = 100
##Percentage of damage reduction
@export var toughness:int = 20

var hurtbox:HurtBox = null

#Default Health
var base_health:int = 100

var alive:bool = true

#Effects
var base_effects:Dictionary = {
	"INVINCIBILITY": 0.0,
	"WOUNDED": 0.0,
}

#Duration in seconds
var effects:Dictionary = {
}

func _ready():
	effects = base_effects
	base_health = health

func _physics_process(delta):
	for eff in effects.keys():
		effects[eff] = max(0.0,effects[eff]-delta)

func add_damage(value:int):
	if alive:
		if !has_effect("invincibility"):
			var damage:int = round(value*(1-float(toughness)/100))
			health = max(0,health-damage)
			if health == 0:
				die()
	
func add_heal(value:int):
	if alive:
		if !has_effect("wounded"):
			health = min(health+value,base_health)

func has_effect(effect_name:String) -> bool:
	effect_name = effect_name.to_upper()
	if effects.has(effect_name):
		return effects[effect_name]>0.0
	else:
		return false

func set_effect(effect_name:String,value:float):
	effects[effect_name] = value
	hurtbox.effect_applied.emit(effect_name,value)

func add_effect(effect_name:String,value:float):
	effects[effect_name] += value
	hurtbox.effect_applied.emit(effect_name,effects[effect_name])

func die():
	hurtbox.died.emit()
	effects = base_effects
	alive = false

func revive():
	hurtbox.revived.emit()
	effects = base_effects
	health = base_health
	alive = true
