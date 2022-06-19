require("units/weapons/GenericProjectileWeapon")
require("shared/TableAlgorithms")
if not HarvesterWeapon then
	HarvesterWeapon = class(GenericProjectileWeapon)
end
HarvesterWeapon.init = function(l_1_0, l_1_1)
	GenericProjectileWeapon.init(l_1_0, l_1_1)
	l_1_0._targets = {}
	l_1_0._target_list = {}
	l_1_0._current_target_1 = nil
end

HarvesterWeapon.fire = function(l_2_0, l_2_1)
	if TableAlgorithms.is_empty(l_2_0._targets) then
		l_2_0._targets = World:unit_manager():get_units(managers.slot:get_mask("harvester_targets"))
	end
	l_2_0:_update_target_list()
	local l_2_2 = nil
	if #l_2_0._target_list > 0 then
		l_2_2 = l_2_0:_find_unit(l_2_0._target_list[1])
		table.remove(l_2_0._target_list, 1)
	end
	cat_print("debug", "harvester fire!")
	if not l_2_2 then
		cat_print("debug", "Couldn't find a current target")
		return 
	end
	l_2_0._wdata.aim_target_position = l_2_2:position()
	GenericProjectileWeapon.fire(l_2_0, l_2_1)
end

HarvesterWeapon._update_target_list = function(l_3_0)
	if l_3_0._current_target_1 ~= l_3_0._wdata.targets[1] then
		for l_3_4 = 1, 20 do
			l_3_0._target_list[l_3_4] = l_3_0._wdata.targets[l_3_4]
		end
		l_3_0._current_target_1 = l_3_0._wdata.targets[1]
	end
end

HarvesterWeapon._find_unit = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	for i_0,i_1 in pairs(l_4_0._targets) do
		if i_1:name() == l_4_1 then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


