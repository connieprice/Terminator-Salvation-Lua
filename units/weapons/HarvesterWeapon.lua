require("units/weapons/GenericProjectileWeapon")
require("shared/TableAlgorithms")
HarvesterWeapon = HarvesterWeapon or class(GenericProjectileWeapon)
function HarvesterWeapon.init(A0_0, A1_1)
	GenericProjectileWeapon.init(A0_0, A1_1)
	A0_0._targets = {}
	A0_0._target_list = {}
	A0_0._current_target_1 = nil
end
function HarvesterWeapon.fire(A0_2, A1_3)
	local L2_4
	L2_4 = TableAlgorithms
	L2_4 = L2_4.is_empty
	L2_4 = L2_4(A0_2._targets)
	if L2_4 then
		L2_4 = World
		L2_4 = L2_4.unit_manager
		L2_4 = L2_4(L2_4)
		L2_4 = L2_4.get_units
		L2_4 = L2_4(L2_4, managers.slot:get_mask("harvester_targets"))
		A0_2._targets = L2_4
	end
	L2_4 = A0_2._update_target_list
	L2_4(A0_2)
	L2_4 = nil
	if #A0_2._target_list > 0 then
		L2_4 = A0_2:_find_unit(A0_2._target_list[1])
		table.remove(A0_2._target_list, 1)
	end
	cat_print("debug", "harvester fire!")
	if not L2_4 then
		cat_print("debug", "Couldn't find a current target")
		return
	end
	A0_2._wdata.aim_target_position = L2_4:position()
	GenericProjectileWeapon.fire(A0_2, A1_3)
end
function HarvesterWeapon._update_target_list(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L6_10
	if L1_6 ~= L2_7 then
		for L4_9 = 1, 20 do
			L6_10 = A0_5._target_list
			L6_10[L4_9] = A0_5._wdata.targets[L4_9]
		end
		A0_5._current_target_1 = L1_6
	end
end
function HarvesterWeapon._find_unit(A0_11, A1_12)
	for 