require("units/DestroyedSequenceBodyDamage")
require("units/BodyDamageGroup")
require("units/BodyDamageGroupMember")
require("units/InvulnerableBodyDamage")
require("units/damage/StunDamage")
require("units/damage/StunBodySetup")
SpiderDamage = SpiderDamage or class(UnitDamage)
SpiderDamage._BODY_NAMES = {
	b_hips,
	b_flesh_back,
	b_arm_left,
	b_gun_left,
	b_arm_right,
	b_gun_right,
	b_shield_left,
	b_shield_right
}
SpiderDamage._BATTERIES = {
	{
		body_names = {"b_battery"},
		name = "battery",
		destroyed_sequence_name = "",
		damaged_sequence_name = "dmg_battery"
	}
}
SpiderDamage._HURT_REDIRECTS = {
	"hurt_front",
	"hurt_rear",
	"hurt_right",
	"hurt_left"
}
SpiderDamage._STUN_BODY_SETUPS = {
	StunBodySetup:new("stun", tweak_data.enemy.spider.STUN_MAX_HEALTH, tweak_data.enemy.spider.STUN_HEALTH_PER_SECOND, false)
}
function SpiderDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	UnitDamage.init(A0_0, A1_1)
	A0_0._group_destroyed = {}
	A0_0:_setup_bodies()
	A0_0._time_until_next_hurt = 0
	A0_0:register_damage_callback(function(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
		_UPVALUE0_:_on_damage(A0_7, A1_8, A2_9, A3_10, A5_12)
	end)
	A0_0._stun_damage = StunDamage:new(A1_1, A0_0, SpiderDamage._STUN_BODY_SETUPS)
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0._outline_weakspots = {}
	A0_0._outline_weakspots[1] = {
		body_name = "b_weakspot_left",
		obj = A0_0._unit:get_object("g_outline_b_weakspot_left")
	}
	A0_0._outline_weakspots[2] = {
		body_name = "b_weakspot_right",
		obj = A0_0._unit:get_object("g_outline_b_weakspot_right")
	}
	A0_0._outline_weakspots[3] = {
		body_name = "b_battery",
		obj = A0_0._unit:get_object("g_outline_b_battery")
	}
	A0_0._unit:damage_data().health = tweak_data.enemy.spider.HEALTH
end
function SpiderDamage.destroy(A0_13)
	A0_13._emitter:destroy()
	A0_13._stun_damage:destroy()
end
function SpiderDamage.update_damage(A0_14, A1_15, A2_16, A3_17)
	A0_14._time_until_next_hurt = A0_14._time_until_next_hurt - A3_17
	A0_14._stun_damage:update(A3_17)
end
function SpiderDamage._setup_bodies(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24, L7_25
	L4_22 = tweak_data
	L4_22 = L4_22.enemy
	L4_22 = L4_22.spider
	L4_22 = L4_22.BATTERY_ENDURANCE
	L5_23 = true
	function L6_24(A0_26)
		_UPVALUE0_:battery_destroyed(A0_26)
	end
	L1_19(L2_20, L3_21, L4_22, L5_23, L6_24)
	for L4_22, L5_23 in L1_19(L2_20) do
		L6_24 = A0_18._unit
		L7_25 = L6_24
		L6_24 = L6_24.body
		L6_24 = L6_24(L7_25, L5_23)
		L7_25 = assert
		L7_25(L6_24)
		L7_25 = BodyDamage
		L7_25 = L7_25.new
		L7_25 = L7_25(L7_25, A0_18._unit, A0_18, L6_24, A0_18._unit_element:get_body_element(L5_23))
		A0_18:_set_damage_body_extension(L6_24, L7_25)
	end
end
function SpiderDamage._set_damage_body_extension(A0_27, A1_28, A2_29)
	A1_28:set_extension(A1_28:extension() or {})
	A1_28:extension().damage = A2_29
end
function SpiderDamage._setup_body_group(A0_30, A1_31, A2_32, A3_33, A4_34)
	local L5_35, L6_36, L7_37, L8_38, L9_39, L10_40, L11_41, L12_42, L13_43, L14_44, L15_45, L16_46
	for L8_38, L9_39 in L5_35(L6_36) do
		L10_40 = BodyDamageGroup
		L10_40 = L10_40.new
		L14_44 = L9_39.destroyed_sequence_name
		L15_45 = L9_39.damaged_sequence_name
		L16_46 = L9_39.name
		L10_40 = L10_40(L11_41, L12_42, L13_43, L14_44, L15_45, L16_46, A2_32, A4_34, nil, 0.5)
		for L14_44, L15_45 in L11_41(L12_42) do
			L16_46 = A0_30._unit
			L16_46 = L16_46.body
			L16_46 = L16_46(L16_46, L15_45)
			L16_46:set_extension(L16_46:extension() or {})
			L16_46:extension().damage = BodyDamageGroupMember:new(A0_30._unit, A0_30, L16_46, A0_30._unit_element:get_body_element(L15_45), L10_40, A3_33)
		end
		L11_41[L12_42] = false
	end
end
function SpiderDamage.fully_damaged(A0_47, A1_48, A2_49, A3_50, A4_51, A5_52, A6_53, A7_54, A8_55)
	A0_47._unit:damage_data().death_reason = A2_49
	A0_47._unit:set_slot(6)
end
function SpiderDamage._on_damage(A0_56, A1_57, A2_58, A3_59, A4_60, A5_61)
	local L6_62, L7_63, L8_64, L9_65
	if A5_61 and not (A1_57 <= 0) then
		L6_62 = A0_56._unit
		L7_63 = L6_62
		L6_62 = L6_62.damage_data
		L6_62 = L6_62(L7_63)
		L7_63 = L6_62
		L6_62 = L6_62.is_fully_damaged
		L6_62 = L6_62(L7_63)
	elseif L6_62 then
		return
	end
	L6_62 = A0_56._emitter
	L7_63 = L6_62
	L6_62 = L6_62.unit_damaged
	L8_64 = A0_56._unit
	L9_65 = A5_61
	L6_62(L7_63, L8_64, L9_65, A4_60)
	L6_62 = A0_56._time_until_next_hurt
	if L6_62 <= 0 then
		L6_62 = A0_56._unit
		L7_63 = L6_62
		L6_62 = L6_62.rotation
		L6_62 = L6_62(L7_63)
		L7_63 = L6_62
		L6_62 = L6_62.y
		L6_62 = L6_62(L7_63)
		L8_64 = A3_59
		L7_63 = A3_59.to_polar_with_reference
		L9_65 = L6_62
		L7_63 = L7_63(L8_64, L9_65, math.UP)
		L8_64 = L7_63.spin
		if L8_64 >= 135 or L8_64 <= -135 then
			L9_65 = SpiderDamage
			L9_65 = L9_65._HURT_REDIRECTS
			L9_65 = L9_65[1]
		elseif not L9_65 then
			if L8_64 <= 45 and L8_64 >= -45 then
				L9_65 = SpiderDamage
				L9_65 = L9_65._HURT_REDIRECTS
				L9_65 = L9_65[2]
			elseif not L9_65 then
				if L8_64 >= 45 and L8_64 <= 135 then
					L9_65 = SpiderDamage
					L9_65 = L9_65._HURT_REDIRECTS
					L9_65 = L9_65[3]
				elseif not L9_65 then
					if L8_64 <= -45 and L8_64 >= -135 then
						L9_65 = SpiderDamage
						L9_65 = L9_65._HURT_REDIRECTS
						L9_65 = L9_65[4]
					elseif not L9_65 then
						L9_65 = SpiderDamage
						L9_65 = L9_65._HURT_REDIRECTS
						L9_65 = L9_65[1]
					end
				end
			end
		end
		A0_56._unit:play_redirect(L9_65)
		A0_56._time_until_next_hurt = tweak_data.enemy.spider.TIME_BETWEEN_HURTS.min + math.random() * (tweak_data.enemy.spider.TIME_BETWEEN_HURTS.max - tweak_data.enemy.spider.TIME_BETWEEN_HURTS.min)
	end
end
function SpiderDamage.arm_destroyed(A0_66, A1_67)
	A0_66:body_group_destroyed(A1_67)
	A0_66._unit:base():arm_destroyed(A1_67.name)
end
function SpiderDamage.shield_destroyed(A0_68, A1_69)
	A0_68:body_group_destroyed(A1_69)
end
function SpiderDamage.battery_destroyed(A0_70, A1_71)
	A0_70:body_group_destroyed(A1_71)
	if A0_70._group_destroyed[SpiderDamage._BATTERIES[1].name] then
		A0_70._unit:damage():set_fully_damaged()
		A0_70._unit:damage_data().death_reason = "battery"
	end
end
function SpiderDamage.body_group_destroyed(A0_72, A1_73)
	assert(A1_73)
	A0_72._group_destroyed[A1_73.name] = true
end
function SpiderDamage.get_outline_weakspots(A0_74)
	local L1_75
	L1_75 = A0_74._outline_weakspots
	return L1_75
end
function SpiderDamage.check_outline_weakspot(A0_76, A1_77)
	if A0_76._outline_weakspots then
		for 