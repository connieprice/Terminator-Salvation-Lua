core:module("CoreUnit")
core:require_module("CoreCode")
function table.get_ray_ignore_args(...)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6
	L1_1 = {}
	L6_6 = ...
	;({
		[4] = ...
	})[1] = L4_4
	;({
		[4] = ...
	})[2] = L5_5
	;({
		[4] = ...
	})[3] = L6_6
	for L5_5, L6_6 in L2_2(L3_3) do
		if CoreCode.alive(L6_6) then
			table.insert(L1_1, "ignore_unit")
			table.insert(L1_1, L6_6)
		end
	end
	return L2_2(L3_3)
end
function get_distance_to_body(A0_7, A1_8)
	local L2_9, L3_10, L4_11
	L3_10 = A0_7
	L2_9 = A0_7.root_object
	L2_9 = L2_9(L3_10)
	L4_11 = L2_9
	L3_10 = L2_9.distance_to_bounding_volume
	L3_10 = L3_10(L4_11, A1_8)
	L4_11 = L2_9.children
	L4_11 = L4_11(L2_9)
	for 