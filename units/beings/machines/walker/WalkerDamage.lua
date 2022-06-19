local L0_0
L0_0 = require
L0_0("units/UnitDamage")
L0_0 = require
L0_0("units/damage/StunDamage")
L0_0 = require
L0_0("units/damage/StunBodySetup")
L0_0 = require
L0_0("units/beings/machines/walker/WalkerTweakData")
function L0_0(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1.rotation
	L2_3 = L2_3(A0_1)
	L2_3 = L2_3.y
	L2_3 = L2_3(L2_3)
	return math.dot(L2_3, A1_2) < 0
end
;({}).FRONT = 0
;({}).BACK = 1
;({}).LEFT = 2
;({}).RIGHT = 3
WalkerDamage = WalkerDamage or class(UnitDamage)
function WalkerDamage.init(A0_4, A1_5, A2_6, A3_7, A4_8, A5_9, A6_10)
	UnitDamage.init(A0_4, A1_5, BodyDamage, A3_7, A4_8, A5_9, A6_10)
	A1_5:set_extension_update_enabled("damage", true)
	A0_4._time_until_next_hurt = 0
	A0_4._damage_state_index = 0
	A0_4._movement_speed_acceleration = 1
	A0_4._enemy_data = A1_5:enemy_data()
	A0_4._enemy_data.damage_movement_speed_multiplier = 1
	A0_4._stun_damage = StunDamage:new(A1_5, A0_4, _UPVALUE0_)
	A0_4:register_damage_callback(function(A0_11, A1_12, A2_13, A3_14, A4_15, A5_16)
		_UPVALUE0_:_on_damage(A0_11, A1_12, A2_13, A3_14, A5_16)
	end)
	A0_4._outline_weakspots = {}
	A0_4._outline_graphic_objects = {}
	if not A0_4._skinjob then
		A0_4._outline_weakspots[1] = {
			body_name = "chest_weakspot",
			obj = A0_4._unit:get_object("g_outline_chest")
		}
		A0_4._unit:damage_data().health = tweak_data.enemy.metal_walker.HEALTH
	else
		A0_4._outline_graphic_objects = A0_4._unit:get_objects("g_outline*")
		A0_4._unit:damage_data().health = tweak_data.enemy.skinjob.HEALTH
	end
end
function WalkerDamage.destroy(A0_17)
	A0_17._stun_damage:destroy()
end
function WalkerDamage.fully_damaged(A0_18, A1_19)
	A0_18._unit:set_slot(6)
end
function WalkerDamage._update_movement_speed(A0_20, A1_21)
	local L2_22, L3_23, L4_24, L5_25, L6_26
	L2_22 = A0_20._movement_speed_acceleration
	L3_23 = math
	L3_23 = L3_23.min
	L4_24 = 1
	L5_25 = L2_22 + A1_21
	L3_23 = L3_23(L4_24, L5_25)
	L4_24 = A0_20._unit
	L5_25 = L4_24
	L4_24 = L4_24.anim_state_machine
	L4_24 = L4_24(L5_25)
	L6_26 = A0_20
	L5_25 = A0_20._movement_speed
	L5_25 = L5_25(L6_26, L4_24)
	L6_26 = math
	L6_26 = L6_26.min
	L6_26 = L6_26(1, L5_25 + A1_21 * L3_23)
	A0_20:_set_movement_speed(L4_24, L6_26)
	A0_20._movement_speed_acceleration = L3_23
end
function WalkerDamage._update_movement_speed_on_damage(A0_27, A1_28, A2_29)
	local L3_30, L4_31, L5_32, L6_33, L7_34, L8_35, L9_36, L10_37, L11_38, L12_39, L13_40, L14_41, L15_42, L16_43, L17_44, L18_45
	L3_30 = {
		L4_31,
		L5_32,
		L6_33
	}
	L4_31 = {}
	L4_31.min_damage = 0
	L4_31.max_damage = 5
	L4_31.min_speed = 1
	L4_31.max_speed = 0.7
	L4_31.min_acceleration = 1
	L4_31.max_acceleration = 1
	L5_32 = {}
	L5_32.min_damage = 5
	L5_32.max_damage = 10
	L5_32.min_speed = 0.7
	L5_32.max_speed = 0.2
	L5_32.min_acceleration = 1
	L5_32.max_acceleration = 1
	L6_33 = {}
	L6_33.min_damage = 10
	L6_33.max_damage = nil
	L6_33.min_speed = 0.2
	L6_33.max_speed = 0.2
	L6_33.min_acceleration = 1
	L6_33.max_acceleration = 1
	L4_31 = 0.1
	L5_32, L6_33 = nil, nil
	for L10_37, L11_38 in L7_34(L8_35) do
		L12_39 = L11_38.min_damage
		L13_40 = assert
		L14_41 = L12_39
		L13_40(L14_41)
		L13_40 = L11_38.max_damage
		if A1_28 >= L12_39 and (not L13_40 or A1_28 < L13_40) then
			L14_41 = L11_38.min_speed
			L15_42 = L11_38.min_acceleration
			if not L13_40 then
				L5_32 = L14_41
				L6_33 = L15_42
			else
				L16_43 = L11_38.max_speed
				L17_44 = L11_38.max_acceleration
				L18_45 = A1_28 - L12_39
				L18_45 = L18_45 / (L13_40 - L12_39)
				assert(L18_45 >= 0 and L18_45 <= 1, L18_45)
				L5_32 = L14_41 + (L16_43 - L14_41) * L18_45
				L6_33 = L15_42 + (L17_44 - L15_42) * L18_45
			end
		end
	end
	L7_34(L8_35)
	L7_34(L8_35)
	L10_37 = L8_35
	if L9_36 > 0 then
		L10_37 = math
		L10_37 = L10_37.dot
		L11_38 = L8_35
		L12_39 = A2_29
		L10_37 = L10_37(L11_38, L12_39)
		L10_37 = L10_37 < 0
		if not L10_37 then
			return
		end
	end
	L11_38 = L7_34
	L10_37 = L7_34.anim_state_machine
	L10_37 = L10_37(L11_38)
	L12_39 = A0_27
	L11_38 = A0_27._movement_speed
	L13_40 = L10_37
	L11_38 = L11_38(L12_39, L13_40)
	if L5_32 < L11_38 then
		L12_39 = math
		L12_39 = L12_39.max
		L13_40 = L5_32
		L14_41 = A1_28 * L4_31
		L14_41 = L11_38 - L14_41
		L12_39 = L12_39(L13_40, L14_41)
		L14_41 = A0_27
		L13_40 = A0_27._set_movement_speed
		L15_42 = L10_37
		L16_43 = L12_39
		L13_40(L14_41, L15_42, L16_43)
	end
	L12_39 = A0_27._movement_speed_acceleration
	if L6_33 < L12_39 then
		A0_27._movement_speed_acceleration = L6_33
	end
end
function WalkerDamage._on_damage(A0_46, A1_47, A2_48, A3_49, A4_50, A5_51)
	local L6_52, L7_53, L8_54, L9_55
	L6_52 = A0_46._unit
	L8_54 = A0_46
	L7_53 = A0_46._update_movement_speed_on_damage
	L9_55 = A1_47
	L7_53(L8_54, L9_55, A3_49)
	if A4_50 == "explosion" then
		L8_54 = L6_52
		L7_53 = L6_52.rotation
		L7_53 = L7_53(L8_54)
		L8_54 = _UPVALUE0_
		L9_55 = L7_53
		L8_54 = L8_54(L9_55, A3_49)
		L9_55 = _UPVALUE1_
		L9_55 = L9_55[L8_54]
		assert(L9_55)
		L6_52:play_redirect(L9_55)
	elseif A5_51 then
		L7_53 = A0_46._time_until_next_hurt
		if L7_53 <= 0 then
			L8_54 = A5_51
			L7_53 = A5_51.name
			L7_53 = L7_53(L8_54)
			L8_54 = _UPVALUE2_
			L8_54 = L8_54[L7_53]
			if L8_54 then
				L9_55 = L8_54
				L9_55 = L9_55(L6_52, A1_47, A2_48, A3_49, A4_50, A5_51)
				if L9_55 then
					L6_52:play_redirect(L9_55)
					A0_46._time_until_next_hurt = _UPVALUE3_.min + math.random() * (_UPVALUE3_.max - _UPVALUE3_.min)
				end
			end
		end
	end
end
function WalkerDamage._movement_speed(A0_56, A1_57)
	return A0_56._enemy_data.damage_movement_speed_multiplier
end
function WalkerDamage._set_movement_speed(A0_58, A1_59, A2_60)
	A0_58._enemy_data.damage_movement_speed_multiplier = A2_60
end
function WalkerDamage.update(A0_61, A1_62, A2_63, A3_64)
	A0_61._time_until_next_hurt = A0_61._time_until_next_hurt - A3_64
	A0_61:_update_movement_speed(A3_64)
	A0_61._stun_damage:update(A3_64)
end
function WalkerDamage.get_outline_weakspots(A0_65)
	local L1_66
	L1_66 = A0_65._outline_weakspots
	return L1_66
end
function WalkerDamage.check_outline_weakspot(A0_67, A1_68)
	if A0_67._skinjob then
		return A0_67._outline_graphic_objects
	elseif A0_67._outline_weakspots then
		for 