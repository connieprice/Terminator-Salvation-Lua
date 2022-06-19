require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
M249Machinegun = M249Machinegun or class(GenericWeapon)
function M249Machinegun.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	assert(A0_0._reload_unit)
	A0_0._reload = World:spawn_unit(A0_0._reload_unit, A1_1:position(), A1_1:rotation())
	A0_0:reload_attach()
end
function M249Machinegun.destroy(A0_2)
	GenericWeapon.destroy(A0_2)
	if alive(A0_2._reload) then
		A0_2._reload:set_slot(0)
	end
	A0_2._reload = nil
end
function M249Machinegun.setup(A0_3, A1_4)
	GenericWeapon.setup(A0_3, A1_4)
end
function M249Machinegun.fire(A0_5, A1_6)
	local L2_7, L3_8, L4_9
	L2_7 = A0_5._wdata
	L2_7 = L2_7._bullets_in_clip
	L3_8 = 0
	if L2_7 > 12 then
		L4_9 = math
		L4_9 = L4_9.random
		L4_9 = L4_9(0, 1)
		L3_8 = L4_9 * 0.2
	else
		L4_9 = math
		L4_9 = L4_9.max
		L4_9 = L4_9(0, 3 - A0_5._wdata._bullets_in_clip * 0.2)
		L3_8 = L4_9
	end
	L4_9 = math
	L4_9 = L4_9.min
	L4_9 = L4_9(L3_8 + 0.2, 3)
	A0_5._reload:anim_set_time("fire", L3_8)
	A0_5._reload:anim_play_to("fire", L4_9)
	GenericWeapon.fire(A0_5, A1_6)
end
function M249Machinegun.reload_release(A0_10)
	local L1_11, L2_12
	L1_11 = 3
	L2_12 = A0_10._reload
	L2_12 = L2_12.anim_set_time
	L2_12(L2_12, "fire", L1_11)
	L2_12 = 3
	A0_10._reload:anim_play_to("fire", L2_12)
	assert(A0_10._user_unit)
	A0_10._user_unit:link("a_weapon_left_back", A0_10._reload, A0_10._reload:orientation_object():name())
end
function M249Machinegun.reload_attach(A0_13)
	local L1_14, L2_15
	L1_14 = 0
	L2_15 = A0_13._reload
	L2_15 = L2_15.anim_set_time
	L2_15(L2_15, "fire", L1_14)
	L2_15 = 0
	A0_13._reload:anim_play_to("fire", L2_15)
	A0_13._unit:link(A0_13._reload_attachment, A0_13._reload, A0_13._reload:orientation_object():name())
	A0_13._reload:set_visible(true)
end
function M249Machinegun.reload_drop(A0_16)
	A0_16._reload:set_visible(false)
end
function M249Machinegun.reload_grab(A0_17)
	A0_17._reload:set_visible(true)
end
