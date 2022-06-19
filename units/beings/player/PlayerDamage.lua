if not PlayerDamage then
	PlayerDamage = class(UnitDamage)
end
PlayerDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	if not l_1_3 then
		l_1_3 = {}
	end
	l_1_3.Afro = PlayerAfroDamage
	UnitDamage.init(l_1_0, l_1_1, PlayerBodyDamage, l_1_3, true, true, l_1_6)
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._brush = Draw:brush(Color(1, 0, 0))
	l_1_0._brush:set_font("editor_font", 5)
	l_1_0._health_regen_per_second = 0
	l_1_0._health_regen_delay = 0
	l_1_0._health_regen_multiplier = 1
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
end

PlayerDamage.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
end

PlayerDamage.save = function(l_3_0, l_3_1)
	UnitDamage.save(l_3_0, l_3_1)
end

PlayerDamage.load = function(l_4_0, l_4_1)
	UnitDamage.load(l_4_0, l_4_1)
end

PlayerDamage.fully_damaged = function(l_5_0, l_5_1)
end

PlayerDamage.add_damage = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
	if alive(l_6_2) and l_6_2:slot() == l_6_0._unit:slot() then
		return 
	end
	UnitDamage.add_damage(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
	l_6_0._player_data.time_since_damage = 0
	l_6_0._player_data.last_hit_direction = l_6_6
	l_6_0._emitter:unit_player_damage(l_6_0._unit, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
end

PlayerDamage.update_player_damage = function(l_7_0, l_7_1, l_7_2, l_7_3)
	l_7_0._player_data.time_since_damage = l_7_0._player_data.time_since_damage + l_7_3
	if not l_7_0._damage_data then
		l_7_0._damage_data = l_7_1:damage_data()
	end
	if l_7_0._damage_data:is_fully_damaged() then
		return 
	end
	if managers.dynamic_dialog:is_in_combat() then
		return 
	end
	if l_7_0._health_regen_delay < l_7_0._player_data.time_since_damage and l_7_0._damage_data.damage > 0 then
		l_7_0._damage_data.damage = math.max(0, l_7_0._damage_data.damage - l_7_3 * l_7_0._health_regen_per_second * l_7_0._health_regen_multiplier)
	end
end

PlayerDamage.set_health_regen = function(l_8_0, l_8_1, l_8_2)
	l_8_0._health_regen_per_second = l_8_1
	l_8_0._health_regen_delay = l_8_2
end

PlayerDamage.set_health_regen_multiplier = function(l_9_0, l_9_1)
	l_9_0._health_regen_multiplier = l_9_1
end

if not PlayerBodyDamage then
	PlayerBodyDamage = class(BodyDamage)
end
PlayerBodyDamage.init = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4)
	BodyDamage.init(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, "human_flesh")
	l_10_0._unit = l_10_1
	l_10_0._player_data = l_10_1:player_data()
end

PlayerBodyDamage.faith_damage = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4, l_11_5)
	if l_11_0._player_data.on_rail_vehicle or alive(l_11_1) and l_11_0._unit:visibility_query() and not l_11_0._unit:visibility_query():hittable_from_position(l_11_1:position()) then
		return "soft", 0
	end
	local l_11_6 = BodyDamage.faith_damage
	local l_11_7 = l_11_0
	local l_11_8 = l_11_1
	local l_11_9 = l_11_2
	local l_11_10 = l_11_3
	local l_11_11 = l_11_4
	local l_11_12 = l_11_5
	return l_11_6(l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12)
end

if not PlayerAfroDamage then
	PlayerAfroDamage = class(AfroBodyDamage)
end
PlayerAfroDamage.init = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
	AfroBodyDamage.init(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
	l_12_0._action_event_emitter = managers.action_event:create_emitter(l_12_1)
	l_12_0._unit = l_12_1
end

PlayerAfroDamage.destroy = function(l_13_0)
	AfroBodyDamage.destroy(l_13_0)
	l_13_0._action_event_emitter:destroy()
end

PlayerAfroDamage.faith_damage = function(l_14_0, l_14_1, l_14_2, l_14_3, l_14_4, l_14_5)
	l_14_0._unit:player_data().time_since_incoming_fire = 0
	l_14_0._action_event_emitter:unit_afro_hit(l_14_0._unit, l_14_1, l_14_2, l_14_3, l_14_4)
	return "soft", 0
end


