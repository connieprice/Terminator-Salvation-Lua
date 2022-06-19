UnitDeathTrigger = UnitDeathTrigger or class(CoreTriggerBase)
function UnitDeathTrigger.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	L4_4 = CoreTriggerBase
	L4_4 = L4_4.init
	L4_4(A0_0, A1_1, A2_2, A3_3)
	L4_4 = A2_2.parameter
	L4_4 = L4_4(A2_2, "name")
	managers.unit_scripting:define_unit(L4_4)
	managers.unit_scripting:add_unit_death_callback(L4_4, function(...)
		local L2_6, L3_7
		L2_6 = _UPVALUE0_
		L3_7 = L2_6
		L2_6 = L2_6.unit_killed
		L2_6(L3_7, ...)
	end)
end
function UnitDeathTrigger.unit_killed(A0_8)
	A0_8._user:trigger_activated(A0_8._id, 1)
end
