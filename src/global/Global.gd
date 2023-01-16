extends Node

var times_up = false

#var score_villain: int = 0 setget setVillainScore
#var score_hero: int = 0 setget setHeroScore
#var health_bomb: int = 1000

signal character_health_changed(new_health)
signal bomb_damaged(damage)

signal pay_skill(cost)

signal upgrade_skill
signal upgrade_skill1
signal upgrade_skill2
signal upgrade_skill3
signal upgrade_skill4

signal increase_time

signal game_end
