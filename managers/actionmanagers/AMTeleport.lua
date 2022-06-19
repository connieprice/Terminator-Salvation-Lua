AMTeleport = AMTeleport or class(CoreActionElement)
function AMTeleport.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMTeleport.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11
	L1_4 = {}
	for L5_8, L6_9 in L2_5(L3_6) do
		L7_10 = table
		L7_10 = L7_10.insert
		L8_11 = L1_4
		L7_10(L8_11, L6_9.script_name)
	end
	L2_5(L3_6)
	for L5_8, L6_9 in L2_5(L3_6) do
		L7_10 = L1_4[L5_8]
		if L7_10 then
			L7_10 = L1_4[L5_8]
			L8_11 = managers
			L8_11 = L8_11.unit_scripting
			L8_11 = L8_11.get_unit_by_name
			L8_11 = L8_11(L8_11, L7_10)
			if alive(L8_11) then
				UnitSpawnUtility.warp_to(L8_11, L6_9.rotation, L6_9.position)
			else
				Application:error("Unit " .. L7_10 .. " not found!")
			end
		end
	end
	L2_5(L3_6)
end
