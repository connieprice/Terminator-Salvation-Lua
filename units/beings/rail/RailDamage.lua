require("units/UnitDamage")
RailDamage = RailDamage or class(UnitDamage)
function RailDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	UnitDamage.init(A0_0, A1_1, BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A1_1:set_extension_update_enabled("damage", true)
	A0_0._damage_data = A1_1:damage_data()
	A0_0._transl = {}
	A0_0._group_damage = {}
	A0_0._group_destroyed = {}
	A0_0._hit_zones = 0
	A0_0._time_until_next_hurt = 0
	A0_0._time_since_damage = 1000000
	A0_0._damage_unit = false
	A0_0._health_regen_multiplier = 1
	A0_0:register_damage_callback(function(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
		_UPVALUE0_:_on_damage(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
	end)
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0:setup_tweaked_data()
end
function RailDamage.setup_tweaked_data(A0_13)
	local L1_14, L2_15, L3_16, L4_17
	L1_14 = tweak_data
	L1_14 = L1_14.rail
	L1_14 = L1_14.vehicle
	L2_15 = A0_13._unit
	L3_16 = L2_15
	L2_15 = L2_15.name
	L2_15 = L2_15(L3_16)
	L1_14 = L1_14[L2_15]
	if L1_14 then
		L2_15 = ""
		L3_16 = managers
		L3_16 = L3_16.player_slot
		L4_17 = L3_16
		L3_16 = L3_16.number_of_occupied_slots
		L3_16 = L3_16(L4_17)
		if L3_16 == 2 then
			L2_15 = "_COOP"
		end
		L3_16 = "HEALTH"
		L4_17 = L2_15
		L3_16 = L3_16 .. L4_17
		L3_16 = L1_14[L3_16]
		L3_16 = L3_16 or L1_14.HEALTH
		if L3_16 then
			L4_17 = A0_13._unit
			L4_17 = L4_17.damage_data
			L4_17 = L4_17(L4_17)
			L4_17.health = L3_16
		end
		L4_17 = "PERCENT_HEALTH_REGEN_PER_SECOND"
		L4_17 = L4_17 .. L2_15
		L4_17 = L1_14[L4_17]
		L4_17 = L4_17 or L1_14.PERCENT_HEALTH_REGEN_PER_SECOND
		A0_13._percent_health_regen_per_second = L4_17
		L4_17 = "HEALTH_REGEN_DELAY"
		L4_17 = L4_17 .. L2_15
		L4_17 = L1_14[L4_17]
		if not L4_17 then
			L4_17 = L1_14.HEALTH_REGEN_DELAY
			L4_17 = L4_17 or 0
		end
		A0_13._health_regen_delay = L4_17
		L4_17 = tweak_data
		L4_17 = L4_17.rail
		L4_17 = L4_17.vehicle
		L4_17 = L4_17.DEBUG
		if L4_17 then
			L4_17 = "SPAWNING"
			L4_17 = L4_17 .. L2_15 .. " " .. A0_13._unit:name() .. " HEALTH" .. L2_15 .. "=" .. A0_13._unit:damage_data().health
			if A0_13._percent_health_regen_per_second then
				L4_17 = L4_17 .. ", PERCENT_HEALTH_REGEN_PER_SECOND" .. L2_15 .. "=" .. string.format("%.3f", A0_13._percent_health_regen_per_second) .. ", HEALTH_REGEN_DELAY" .. L2_15 .. "=" .. string.format("%.3f", A0_13._health_regen_delay)
			end
			cat_debug("rail", L4_17)
		end
	else
		L2_15 = Application
		L3_16 = L2_15
		L2_15 = L2_15.debug
		L4_17 = A0_13._unit
		L4_17 = L4_17.name
		L4_17 = L4_17(L4_17)
		L4_17 = L4_17 .. " was not found in tweak_data. It will not be tweaked depending on difficulty-level."
		L2_15(L3_16, L4_17)
	end
end
function RailDamage.set_health_param_value(A0_18, A1_19)
	if not managers.save:has_primary_user() then
		return
	end
	if managers.player_slot:number_of_occupied_slots() == 2 then
	end
	if (tonumber(A1_19[(managers.save:profile().difficulty_level or 2) + 3]) or tonumber(A1_19[managers.save:profile().difficulty_level or 2])) and A0_18._health_param_type and A0_18._health_param_type ~= "" then
		if A0_18._health_param_type == "HEALTH" then
			A0_18._unit:damage_data().health = tonumber(A1_19[(managers.save:profile().difficulty_level or 2) + 3]) or tonumber(A1_19[managers.save:profile().difficulty_level or 2])
			A0_18._unit:damage_data().damage = 0
		elseif A0_18._health_param_type == "PERCENT_HEALTH_REGEN_PER_SECOND" then
			A0_18._percent_health_regen_per_second = tonumber(A1_19[(managers.save:profile().difficulty_level or 2) + 3]) or tonumber(A1_19[managers.save:profile().difficulty_level or 2])
		elseif A0_18._health_param_type == "HEALTH_REGEN_DELAY" then
			A0_18._health_regen_delay = tonumber(A1_19[(managers.save:profile().difficulty_level or 2) + 3]) or tonumber(A1_19[managers.save:profile().difficulty_level or 2])
		end
	end
	A0_18._health_param_type = nil
end
function RailDamage.set_health_param_type(A0_20, A1_21)
	A0_20._health_param_type = A1_21
end
function RailDamage.destroy(A0_22)
	UnitDamage.destroy(A0_22)
	A0_22._emitter:destroy()
end
function RailDamage.fully_damaged(A0_23, A1_24, A2_25, A3_26, A4_27, A5_28, A6_29, A7_30, A8_31)
	if A0_23._damage_data.postpone_death then
	else
		function A0_23._post_death_update()
			local L0_32, L1_33
			L0_32 = _UPVALUE0_
			L0_32 = L0_32 or 1
			L1_33 = _UPVALUE1_
			L1_33 = L1_33._damage_data
			L1_33 = L1_33.health
			L0_32 = L0_32 / L1_33
			L1_33 = _UPVALUE1_
			L1_33 = L1_33._unit_destroyed_sequence
			if _UPVALUE1_._bullseye_kill_sequence and _UPVALUE2_ == "explosion" and L0_32 >= 1 then
				L1_33 = _UPVALUE1_._bullseye_kill_sequence
			end
			if L1_33 then
				managers.sequence:run_sequence(L1_33, _UPVALUE2_, _UPVALUE3_, _UPVALUE1_._unit, _UPVALUE4_, _UPVALUE5_, _UPVALUE6_, _UPVALUE7_, _UPVALUE0_, _UPVALUE8_, nil)
			end
		end
		A0_23._unit:base():fully_damaged()
	end
end
function RailDamage._on_damage(A0_34, A1_35, A2_36, A3_37, A4_38, A5_39, A6_40)
	if A6_40 then
		A0_34._emitter:unit_damaged(A0_34._unit, A6_40, A4_38)
	end
end
function RailDamage._setup_body_group(A0_41, A1_42)
	local L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54
	A0_41._damage_struct = A1_42
	A0_41._damage_unit = L2_43
	if L2_43 then
		for L5_46, L6_47 in L2_43(L3_44) do
			L7_48 = A0_41._group_damage
			L7_48[L8_49] = L9_50
			L7_48 = L6_47.zone
			if L7_48 then
				A0_41._hit_zones = L8_49
				L8_49[L9_50] = L10_51
			end
			L8_49.zone = L7_48
			L11_52 = A0_41._unit
			L12_53 = A0_41
			L13_54 = L6_47.destroyed_sequence_name
			L8_49.dmg = L9_50
			for L11_52, L12_53 in L8_49(L9_50) do
				L13_54 = A0_41._unit
				L13_54 = L13_54.body
				L13_54 = L13_54(L13_54, L12_53)
				L13_54:set_extension(L13_54:extension() or {})
				L13_54:extension().damage = BodyDamageGroupMember:new(A0_41._unit, A0_41, L13_54, A0_41._unit_element:get_body_element(L12_53), A0_41._group_damage[L6_47.name].dmg, A1_42.damage_unit)
			end
			L8_49[L9_50] = false
		end
	end
	L2_43.total_damage = L3_44
	A0_41._unit_destroyed_sequence = L2_43
	A0_41._bullseye_kill_sequence = L2_43
	A0_41._current_step = L2_43
	A0_41._current_step_tot = L2_43
	L5_46 = A0_41._current_step
	L6_47 = 0
	L2_43(L3_44, L4_45, L5_46, L6_47)
	L5_46 = A0_41._current_step_tot
	L6_47 = 0
	L2_43(L3_44, L4_45, L5_46, L6_47)
end
function RailDamage.body_group_destroyed(A0_55, A1_56)
	assert(A1_56)
	A0_55._group_destroyed[A1_56.name] = true
	A0_55._damage_data.damage = A0_55._damage_data.damage + 1
end
function RailDamage.is_body_group_destroyed(A0_57, A1_58)
	return A0_57._group_destroyed[A1_58]
end
function RailDamage.zone_destroyed(A0_59, A1_60)
	local L2_61
	L2_61 = A0_59._transl
	L2_61 = L2_61[A1_60]
	return A0_59._group_destroyed[L2_61]
end
function RailDamage.activate_body_group(A0_62, A1_63, A2_64)
	local L3_65, L4_66
	L3_65 = A0_62._transl
	L3_65 = L3_65[A1_63]
	L4_66 = A0_62._group_damage
	L4_66 = L4_66[L3_65]
	if L4_66 == nil or L4_66.zone == nil then
		return
	end
	L4_66.dmg:activate(A2_64)
	if A2_64 == true then
		managers.sequence:run_sequence_simple("activate_hz_" .. L4_66.zone, A0_62._unit)
	else
		managers.sequence:run_sequence_simple("deactivate_hz_" .. L4_66.zone, A0_62._unit)
	end
end
function RailDamage.check_god_mode(A0_67)
	A0_67._player_in_vehicle = A0_67._player_in_vehicle or A0_67._unit:base():get_players_in_vehicle()[1]
	if A0_67._player_in_vehicle then
		return A0_67._player_in_vehicle:damage():immune_to_damage()
	else
		return false
	end
end
function RailDamage.update(A0_68, A1_69, A2_70, A3_71)
	A0_68._time_until_next_hurt = A0_68._time_until_next_hurt - A3_71
	if A0_68._percent_health_regen_per_second then
		A0_68:update_health_regen(A2_70, A3_71)
	end
	A0_68:unit_damage_steps_current(A0_68._damage_struct.unit_damage_steps)
	A0_68:unit_damage_steps_total(A0_68._damage_struct.unit_damage_steps_total)
	if A0_68._post_death_update then
		A0_68._post_death_update()
		A0_68._post_death_update = nil
	end
end
function RailDamage.set_health_regen_multiplier(A0_72, A1_73)
	A0_72._health_regen_multiplier = A1_73
end
function RailDamage.update_health_regen(A0_74, A1_75, A2_76)
	local L3_77, L4_78, L5_79, L6_80
	L3_77 = A0_74._time_since_damage
	L3_77 = L3_77 + A2_76
	A0_74._time_since_damage = L3_77
	L3_77 = A0_74._time_since_damage
	L4_78 = A0_74._health_regen_delay
	if L3_77 > L4_78 then
		L3_77 = A0_74._damage_data
		L3_77 = L3_77.damage
		if L3_77 > 0 then
			L3_77 = A0_74._damage_data
			L4_78 = A0_74._damage_data
			L4_78 = L4_78.damage
			L5_79 = A0_74._damage_data
			L5_79 = L5_79.health
			L5_79 = A2_76 * L5_79
			L6_80 = A0_74._percent_health_regen_per_second
			L5_79 = L5_79 * L6_80
			L6_80 = A0_74._health_regen_multiplier
			L5_79 = L5_79 * L6_80
			L4_78 = L4_78 - L5_79
			L3_77.damage = L4_78
			L3_77 = A0_74._damage_data
			L3_77 = L3_77.damage
			if L3_77 < 0 then
				L3_77 = A0_74._damage_data
				L3_77.damage = 0
			end
		end
	end
end
function RailDamage.debug_draw(A0_81)
	local L1_82, L2_83, L3_84, L4_85, L5_86, L6_87, L7_88, L8_89, L9_90, L10_91, L11_92
	L1_82 = tweak_data
	L1_82 = L1_82.enemy
	L1_82 = L1_82.hk
	L1_82 = L1_82.DEBUG_SHOW_HITZONES
	if L1_82 then
		L1_82 = Draw
		L1_82 = L1_82.pen
		L1_82 = L1_82(L2_83, L3_84)
		for L5_86, L6_87 in L2_83(L3_84) do
			L7_88 = A0_81._group_damage
			L7_88 = L7_88[L6_87]
			L8_89 = L7_88.dmg
			L9_90 = L8_89
			L8_89 = L8_89.is_active
			L8_89 = L8_89(L9_90)
			if L8_89 then
				L8_89 = A0_81._damage_struct
				L8_89 = L8_89.bodies
				L8_89 = L8_89[L5_86]
				L8_89 = L8_89.body_names
				L8_89 = L8_89[1]
				L9_90 = A0_81._unit
				L10_91 = L9_90
				L9_90 = L9_90.body
				L11_92 = L8_89
				L9_90 = L9_90(L10_91, L11_92)
				L10_91 = A0_81._unit
				L11_92 = L10_91
				L10_91 = L10_91.get_object
				L10_91 = L10_91(L11_92, L6_87)
				if L10_91 then
					L11_92 = L10_91.position
					L11_92 = L11_92(L10_91)
					L1_82:sphere(L11_92, 200, 5, 2)
				end
				if L9_90 then
					L11_92 = L9_90.center_of_mass
					L11_92 = L11_92(L9_90)
					L1_82:sphere(L11_92, 200, 5, 2)
				end
			end
		end
	end
end
function RailDamage.get_zone_names(A0_93)
	local L1_94
	L1_94 = "\tThis vehicle has no hitzones\n"
	return L1_94
end
function RailDamage.damage_from_part(A0_95, A1_96, A2_97)
	if A0_95:check_god_mode() or A0_95._unit:damage_data().invulnerable then
		return
	end
	if A0_95._damage_unit then
		A0_95._damage_data.damage = A0_95._damage_data.damage + A1_96
	end
end
function RailDamage.hit_zones_activation(A0_98, A1_99)
	for 