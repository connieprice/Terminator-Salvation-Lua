UnitControlIdManager = UnitControlIdManager or class()
function UnitControlIdManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._id_to_unit = L1_1
	L1_1 = {}
	A0_0._unit_to_id = L1_1
end
function UnitControlIdManager.get_free_id(A0_2, A1_3)
	for _FORV_5_ = 1, 1024 do
		if A0_2._id_to_unit[_FORV_5_] == nil then
			A0_2._id_to_unit[_FORV_5_] = A1_3
			return _FORV_5_
		end
	end
	error("out of id")
end
function UnitControlIdManager.free_unit_id(A0_4, A1_5)
	local L2_6
	L2_6 = A0_4._unit_to_id
	L2_6 = L2_6[A1_5:key()]
	assert(L2_6)
	A0_4._unit_to_id[A1_5:key()] = nil
	A0_4._id_to_unit[L2_6] = nil
end
function UnitControlIdManager.clear_unit_id_association(A0_7)
	local L1_8
	L1_8 = {}
	A0_7._unit_to_id = L1_8
	L1_8 = {}
	A0_7._id_to_unit = L1_8
end
function UnitControlIdManager.associate_unit_with_id(A0_9, A1_10, A2_11)
	local L3_12
	L3_12 = A0_9._unit_to_id
	L3_12[A1_10:key()] = A2_11
	L3_12 = A0_9._id_to_unit
	L3_12[A2_11] = A1_10
end
function UnitControlIdManager.get_unit_id(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13._unit_to_id
	L2_15 = L2_15[A1_14:key()]
	if L2_15 == nil then
		if A0_13._next_unit_id then
			L2_15 = A0_13._next_unit_id
			A0_13._next_unit_id = nil
		else
			L2_15 = A0_13:get_free_id()
		end
		A0_13:associate_unit_with_id(A1_14, L2_15)
	end
	assert(L2_15)
	return L2_15
end
function UnitControlIdManager.unit_from_id(A0_16, A1_17)
	return A0_16._id_to_unit[A1_17]
end
