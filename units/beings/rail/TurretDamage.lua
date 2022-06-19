if not TurretDamage then
	TurretDamage = class(UnitDamage)
end
TurretDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	if not l_1_3 then
		l_1_3 = {}
	end
	UnitDamage.init(l_1_0, l_1_1, TurretBodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0:set_update_callback("update_turret_damage", true)
	l_1_0._brush = Draw:brush(Color(1, 0, 0))
	l_1_0._brush:set_font("editor_font", 5)
	l_1_0._health_regen_per_second = 0
	l_1_0._health_regen_delay = 0
	l_1_0._time_since_damage = 0
end

TurretDamage.save = function(l_2_0, l_2_1)
	UnitDamage.save(l_2_0, l_2_1)
end

TurretDamage.load = function(l_3_0, l_3_1)
	UnitDamage.load(l_3_0, l_3_1)
end

TurretDamage.destroy = function(l_4_0)
end

TurretDamage.dead = function(l_5_0, l_5_1)
end

TurretDamage.add_damage = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
	UnitDamage.add_damage(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
	l_6_0._unit:base():report_damage(l_6_7, "turret")
	l_6_0._time_since_damage = 0
	l_6_0._last_hit_direction = l_6_6
end

TurretDamage.update_turret_damage = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	l_7_0._time_since_damage = l_7_0._time_since_damage + l_7_3
	if l_7_1:damage_data():is_fully_damaged() then
		return 
	end
	if l_7_0._health_regen_delay < l_7_0._time_since_damage and l_7_1:damage_data().damage > 0 then
		l_7_1:damage_data().damage = l_7_1:damage_data().damage - l_7_3 * l_7_0._health_regen_per_second
	if l_7_1:damage_data().damage < 0 then
		end
		l_7_1:damage_data().damage = 0
	end
end

TurretDamage.set_health_regen = function(l_8_0, l_8_1, l_8_2)
	l_8_0._health_regen_per_second = l_8_1
	l_8_0._health_regen_delay = l_8_2
end

if not TurretBodyDamage then
	TurretBodyDamage = class(BodyDamage)
end
TurretBodyDamage.init = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	BodyDamage.init(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, "human_flesh")
	l_9_0._unit = l_9_1
end


