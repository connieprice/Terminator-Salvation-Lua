require("shared/scheduler/Operation")
RaycastOperation = RaycastOperation or class(Operation)
function RaycastOperation.init(A0_0, A1_1, A2_2, A3_3)
	assert(#A1_1 >= 2)
	A0_0._positions = A1_1
	A0_0._slot_mask = A2_2
	A0_0._ignore_units = A3_3
	A0_0.ray = nil
end
function RaycastOperation.start(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	for L5_9, L6_10 in L2_6(L3_7) do
		if L1_5 then
			L7_11 = nil
			if A0_4._ignore_units then
				L7_11 = World:raycast("ray", L1_5, L6_10, "slot_mask", A0_4._slot_mask, "ignore_unit", A0_4._ignore_units)
			else
				L7_11 = World:raycast("ray", L1_5, L6_10, "slot_mask", A0_4._slot_mask)
			end
			if L7_11 then
				A0_4.ray = L7_11
				return
			end
		end
		L1_5 = L6_10
	end
end
function RaycastOperation.update(A0_12, A1_13)
end
function RaycastOperation.done(A0_14)
	local L1_15
	L1_15 = true
	return L1_15
end
