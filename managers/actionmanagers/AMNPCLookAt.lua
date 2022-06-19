require("shared/TableAlgorithms")
AMNPCLookAt = AMNPCLookAt or class(CoreActionElement)
function AMNPCLookAt.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMNPCLookAt.activate_now(A0_3)
	local L1_4, L2_5
	if TableAlgorithms.count(A0_3.look_at_unit) == 1 then
		L2_5 = managers.unit_scripting:get_unit_by_name(A0_3.look_at_unit[TableAlgorithms.max_index(A0_3.look_at_unit)].script_name)
		if alive(L2_5) then
			L1_4 = L2_5:position()
		else
			L1_4 = A0_3.position
		end
	else
		L1_4 = A0_3.position
	end
	for 