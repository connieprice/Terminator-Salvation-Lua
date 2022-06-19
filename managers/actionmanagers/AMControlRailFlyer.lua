AMControlRailFlyer = AMControlRailFlyer or class(CoreActionElement)
function AMControlRailFlyer.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMControlRailFlyer.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
	L1_4(L2_5, L3_6)
	for L4_7, L5_8 in L1_4(L2_5) do
		L6_9 = managers
		L6_9 = L6_9.unit_scripting
		L6_9 = L6_9.get_unit_by_name
		L6_9 = L6_9(L6_9, L5_8.script_name)
		if alive(L6_9) and L6_9 ~= nil then
			if A0_3.path then
				L6_9:ai_data()._move.path = managers.unit_scripting:get_unit_by_name(A0_3.path.script_name)
			end
			if A0_3.targets then
				L6_9:ai_data()._combat.new_targets = A0_3.targets
			end
			if A0_3.target_range ~= nil and A0_3.target_range ~= "" then
				if A0_3.offset_displacement then
					L6_9:ai_data().input.target_range = L6_9:ai_data().input.target_range + A0_3.target_range * 100
				else
					L6_9:ai_data().input.target_range = A0_3.target_range * 100
				end
			end
			L6_9:ai_data()._move.target_from_behind = A0_3.target_from_behind
			if A0_3.offset_displacement then
				L6_9:ai_data()._move.displacement = L6_9:ai_data()._move.displacement:with_x(L6_9:ai_data()._move.displacement.x + A0_3.displacement_x * 100):with_z(L6_9:ai_data()._move.displacement.z + A0_3.displacement_y * 100)
			else
				if A0_3.displacement_x ~= nil then
					L6_9:ai_data()._move.displacement = L6_9:ai_data()._move.displacement:with_x(A0_3.displacement_x * 100)
				end
				if A0_3.displacement_y ~= nil then
					L6_9:ai_data()._move.displacement = L6_9:ai_data()._move.displacement:with_z(A0_3.displacement_y * 100)
				end
			end
		end
	end
	L1_4(L2_5)
end
