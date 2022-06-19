AttachmentPoint = AttachmentPoint or class()
function AttachmentPoint.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._unit = A1_1
	A0_0._name = A2_2
	A0_0._object = A3_3
	A0_0._attached_units = {}
end
function AttachmentPoint.destroy(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9
	for L4_8, L5_9 in L1_5(L2_6) do
		if alive(L5_9) and L5_9:attachment() then
			L5_9:attachment():detached_from_unit(A0_4._unit)
		end
	end
end
function AttachmentPoint.valid(A0_10)
	return alive(A0_10._unit)
end
function AttachmentPoint.name(A0_11)
	local L1_12
	L1_12 = A0_11._name
	return L1_12
end
function AttachmentPoint.position(A0_13)
	return A0_13._object:position()
end
function AttachmentPoint.rotation(A0_14)
	return A0_14._object:rotation()
end
function AttachmentPoint.attach_unit(A0_15, A1_16, A2_17)
	assert(A1_16:get_object(A2_17))
	assert(TableAlgorithms.count_if(A0_15._attached_units, function(A0_18)
		return A0_18 == _UPVALUE0_
	end) == 0)
	A0_15._unit:link(A0_15._object:name(), A1_16, A2_17)
	table.insert(A0_15._attached_units, A1_16)
	if A1_16:attachment() then
		A1_16:attachment():attached_to_unit(A0_15._unit)
	end
end
function AttachmentPoint.detach_unit(A0_19, A1_20)
	assert(TableAlgorithms.count_if(A0_19._attached_units, function(A0_21)
		return A0_21 == _UPVALUE0_
	end) == 1)
	TableAlgorithms.remove_if(A0_19._attached_units, function(A0_22)
		return A0_22 == _UPVALUE0_
	end)
	if A1_20:attachment() then
		A1_20:attachment():detached_from_unit(A0_19._unit)
	end
end
function AttachmentPoint.attached_units(A0_23)
	local L1_24
	L1_24 = A0_23._attached_units
	return L1_24
end
