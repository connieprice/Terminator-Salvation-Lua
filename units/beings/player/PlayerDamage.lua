PlayerDamage = PlayerDamage or class(UnitDamage)
function PlayerDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	A3_3 = A3_3 or {}
	A3_3.Afro = PlayerAfroDamage
	UnitDamage.init(A0_0, A1_1, PlayerBodyDamage, A3_3, true, true, A6_6)
	A0_0._player_data = A0_0._unit:player_data()
	A0_0._brush = Draw:brush(Color(1, 0, 0))
	A0_0._brush:set_font("editor_font", 5)
	A0_0._health_regen_per_second = 0
	A0_0._health_regen_delay = 0
	A0_0._health_regen_multiplier = 1
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
end
function PlayerDamage.destroy(A0_7)
	A0_7._emitter:destroy()
end
function PlayerDamage.save(A0_8, A1_9)
	UnitDamage.save(A0_8, A1_9)
end
function PlayerDamage.load(A0_10, A1_11)
	UnitDamage.load(A0_10, A1_11)
end
function PlayerDamage.fully_damaged(A0_12, A1_13)
end
function PlayerDamage.add_damage(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19, A6_20, A7_21, A8_22)
	if alive(A2_16) and A2_16:slot() == A0_14._unit:slot() then
		return
	end
	UnitDamage.add_damage(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19, A6_20, A7_21, A8_22)
	A0_14._player_data.time_since_damage = 0
	A0_14._player_data.last_hit_direction = A6_20
	A0_14._emitter:unit_player_damage(A0_14._unit, A4_18, A5_19, A6_20, A7_21, A8_22)
end
function PlayerDamage.update_player_damage(A0_23, A1_24, A2_25, A3_26)
	A0_23._player_data.time_since_damage = A0_23._player_data.time_since_damage + A3_26
	A0_23._damage_data = A0_23._damage_data or A1_24:damage_data()
	if A0_23._damage_data:is_fully_damaged() then
		return
	end
	if managers.dynamic_dialog:is_in_combat() then
		return
	end
	if A0_23._player_data.time_since_damage > A0_23._health_regen_delay and A0_23._damage_data.damage > 0 then
		A0_23._damage_data.damage = math.max(0, A0_23._damage_data.damage - A3_26 * A0_23._health_regen_per_second * A0_23._health_regen_multiplier)
	end
end
function PlayerDamage.set_health_regen(A0_27, A1_28, A2_29)
	A0_27._health_regen_per_second = A1_28
	A0_27._health_regen_delay = A2_29
end
function PlayerDamage.set_health_regen_multiplier(A0_30, A1_31)
	A0_30._health_regen_multiplier = A1_31
end
PlayerBodyDamage = PlayerBodyDamage or class(BodyDamage)
function PlayerBodyDamage.init(A0_32, A1_33, A2_34, A3_35, A4_36)
	BodyDamage.init(A0_32, A1_33, A2_34, A3_35, A4_36, "human_flesh")
	A0_32._unit = A1_33
	A0_32._player_data = A1_33:player_data()
end
function PlayerBodyDamage.faith_damage(A0_37, A1_38, A2_39, A3_40, A4_41, A5_42)
	if A0_37._player_data.on_rail_vehicle or alive(A1_38) and A0_37._unit:visibility_query() and not A0_37._unit:visibility_query():hittable_from_position(A1_38:position()) then
		return "soft", 0
	end
	return BodyDamage.faith_damage(A0_37, A1_38, A2_39, A3_40, A4_41, A5_42)
end
PlayerAfroDamage = PlayerAfroDamage or class(AfroBodyDamage)
function PlayerAfroDamage.init(A0_43, A1_44, A2_45, A3_46, A4_47)
	AfroBodyDamage.init(A0_43, A1_44, A2_45, A3_46, A4_47)
	A0_43._action_event_emitter = managers.action_event:create_emitter(A1_44)
	A0_43._unit = A1_44
end
function PlayerAfroDamage.destroy(A0_48)
	AfroBodyDamage.destroy(A0_48)
	A0_48._action_event_emitter:destroy()
end
function PlayerAfroDamage.faith_damage(A0_49, A1_50, A2_51, A3_52, A4_53, A5_54)
	A0_49._unit:player_data().time_since_incoming_fire = 0
	A0_49._action_event_emitter:unit_afro_hit(A0_49._unit, A1_50, A2_51, A3_52, A4_53)
	return "soft", 0
end
