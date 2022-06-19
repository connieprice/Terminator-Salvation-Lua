UnitDamage = UnitDamage or class(CoreUnitDamage)
function UnitDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	CoreUnitDamage.init(A0_0, A1_1, A2_2 or BodyDamage, A3_3, A4_4, A5_5, A6_6)
	A0_0._callbacks = {}
	A0_0._can_die = true
end
function UnitDamage.destroy(A0_7)
	CoreUnitDamage:destroy()
end
function UnitDamage.set_damage_multiplier(A0_8, A1_9)
	local L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16
	for L5_13, L6_14 in L2_10(L3_11) do
		L7_15 = A0_8._unit
		L8_16 = L7_15
		L7_15 = L7_15.body
		L7_15 = L7_15(L8_16, L6_14._name)
		if L7_15 then
			L8_16 = L7_15.extension
			L8_16 = L8_16(L7_15)
			L8_16 = L8_16.damage
			assert(L8_16)
			assert(L8_16.set_damage_multiplier, "Body " .. L6_14._name .. " damage type is not derived from BodyDamage")
			L8_16:set_damage_multiplier(A1_9)
		end
	end
end
function UnitDamage.set_immune_to_damage(A0_17, A1_18)
	A0_17._immune_to_damage = A1_18
end
function UnitDamage.immune_to_damage(A0_19)
	local L1_20
	L1_20 = A0_19._immune_to_damage
	return L1_20
end
function UnitDamage.set_can_die(A0_21, A1_22)
	A0_21._can_die = A1_22
end
function UnitDamage.can_die(A0_23)
	local L1_24
	L1_24 = A0_23._can_die
	if L1_24 then
		L1_24 = A0_23._immune_to_damage
		L1_24 = not L1_24
	end
	return L1_24
end
function UnitDamage.set_fully_damaged(A0_25)
	A0_25._unit:damage_data().damage = A0_25._unit:damage_data().health
	A0_25._has_reported_fully_damaged = true
	A0_25:fully_damaged()
end
function UnitDamage.revive(A0_26)
	A0_26._has_reported_fully_damaged = false
	A0_26._unit:damage_data():revive()
end
function UnitDamage.outside_worlds_bounding_box(A0_27)
	CoreUnitDamage.outside_worlds_bounding_box(A0_27)
	if alive(A0_27._unit) then
		if A0_27._unit:player_data() ~= nil then
			managers.user_viewport:pause_all_sounds()
			managers.game_transition:game_over()
		else
			managers.unit_scripting:unit_dead(A0_27._unit)
			A0_27._unit:set_slot(0)
		end
	end
end
function UnitDamage.add_damage(A0_28, A1_29, A2_30, A3_31, A4_32, A5_33, A6_34, A7_35, A8_36)
	local L9_37, L10_38, L11_39, L12_40, L13_41, L14_42
	L9_37 = alive
	L9_37 = L9_37(L10_38)
	if L9_37 then
		L9_37 = A2_30.slot
		L9_37 = L9_37(L10_38)
		if L9_37 == L10_38 then
			return
		end
	end
	L9_37 = A0_28._unit
	L9_37 = L9_37.damage_data
	L9_37 = L9_37(L10_38)
	if L9_37 then
		if L10_38 then
			return
		end
		if not L10_38 then
		elseif L10_38 then
			L9_37.damage = L10_38
		end
		L11_39 = A7_35 >= 0
		L10_38(L11_39)
		if not L10_38 then
			if L10_38 then
				A0_28._has_reported_fully_damaged = true
				L13_41 = A1_29
				L14_42 = A3_31
				L10_38(L11_39, L12_40, L13_41, L14_42, A4_32, A5_33, A6_34, A7_35, A8_36)
				L10_38(L11_39)
				A0_28._attack_unit = A2_30
			end
		end
	end
	for L13_41, L14_42 in L10_38(L11_39) do
		L14_42(A7_35, A5_33, A6_34, A1_29, A2_30, A3_31)
	end
	L13_41 = A2_30
	L14_42 = A3_31
	return L10_38(L11_39, L12_40, L13_41, L14_42, A4_32, A5_33, A6_34, A7_35, A8_36)
end
function UnitDamage.fully_damaged_inflictor(A0_43)
	local L1_44
	L1_44 = A0_43._attack_unit
	return L1_44
end
function UnitDamage.register_damage_callback(A0_45, A1_46)
	A0_45._callbacks[A1_46] = A1_46
end
function UnitDamage.unregister_damage_callback(A0_47, A1_48)
	A0_47._callbacks[A1_48] = nil
end
function UnitDamage.fully_damaged(A0_49, A1_50)
	print("Killing unit " .. A0_49._unit:name())
	A0_49._unit:set_slot(0)
end
function UnitDamage.get_weakspots(A0_51)
	local L1_52, L2_53, L3_54, L4_55
	L1_52 = A0_51._show_weakspots_time
	if L1_52 then
		L1_52 = Application
		L2_53 = L1_52
		L1_52 = L1_52.time
		L1_52 = L1_52(L2_53)
		L2_53 = A0_51._show_weakspots_time
	elseif L1_52 >= L2_53 then
		L1_52 = nil
		return L1_52
	end
	L1_52 = A0_51._weak_spot_name
	if L1_52 then
		L1_52 = A0_51._weak_spot_type
		if L1_52 then
			L1_52 = {}
			L2_53 = nil
			L3_54 = A0_51._unit
			L4_55 = L3_54
			L3_54 = L3_54.damage_data
			L3_54 = L3_54(L4_55)
			L3_54 = L3_54.damage
			L4_55 = A0_51._unit
			L4_55 = L4_55.damage_data
			L4_55 = L4_55(L4_55)
			L4_55 = L4_55.health
			L3_54 = L3_54 < L4_55
			L4_55 = nil
			if A0_51._weak_spot_type == "object3d" then
				L2_53 = A0_51._unit:get_object(A0_51._weak_spot_name):position()
			elseif A0_51._weak_spot_type == "body" then
				L2_53 = A0_51._unit:body(A0_51._weak_spot_name):center_of_mass()
				L4_55 = A0_51._unit:body(A0_51._weak_spot_name):name()
			else
				assert(false)
			end
			if L2_53 then
				table.insert(L1_52, {
					name = A0_51._weak_spot_name,
					pos = L2_53,
					active = L3_54,
					body_name = L4_55
				})
			end
			return L1_52, A0_51._show_weakspots_time, A0_51._show_weakspots_range
		end
	else
		L1_52 = nil
		return L1_52
	end
end
function UnitDamage.set_show_weakspots(A0_56, A1_57, A2_58)
	A0_56._show_weakspots_time = Application:time() + A1_57
	A0_56._show_weakspots_range = A2_58
end
function UnitDamage.get_outline_weakspots(A0_59)
	local L1_60
end
function UnitDamage.check_outline_weakspot(A0_61)
	local L1_62
end
function UnitDamage.hide_all_outline_weakspots(A0_63)
	local L1_64
end
