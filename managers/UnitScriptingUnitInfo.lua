UnitScriptingUnitInfo = UnitScriptingUnitInfo or class()
function UnitScriptingUnitInfo.init(A0_0, A1_1)
	A0_0._name = A1_1
	A0_0._unit = nil
	A0_0._death_callbacks = {}
	A0_0._registered = false
end
function UnitScriptingUnitInfo.destroy(A0_2)
	local L1_3
end
function UnitScriptingUnitInfo.register_unit(A0_4, A1_5)
	A0_4._unit = A1_5
	A0_4._registered = true
end
function UnitScriptingUnitInfo.unregister(A0_6)
	local L1_7
	A0_6._unit = nil
	A0_6._registered = false
end
function UnitScriptingUnitInfo.registered(A0_8)
	local L1_9
	L1_9 = A0_8._registered
	return L1_9
end
function UnitScriptingUnitInfo.add_death_callback(A0_10, A1_11)
	table.insert(A0_10._death_callbacks, A1_11)
end
function UnitScriptingUnitInfo.unit_dead(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17
	for L4_16, L5_17 in L1_13(L2_14) do
		L5_17()
	end
end
function UnitScriptingUnitInfo.unit(A0_18)
	if type(A0_18._unit) == "function" then
		return A0_18._unit()
	else
		return A0_18._unit
	end
end
function UnitScriptingUnitInfo.name(A0_19)
	local L1_20
	L1_20 = A0_19._name
	return L1_20
end
function UnitScriptingUnitInfo.active(A0_21)
	if type(A0_21._unit) == "function" then
		return true
	elseif not A0_21._registered then
		return true
	else
		return alive(A0_21._unit)
	end
end
