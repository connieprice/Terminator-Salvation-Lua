require("shared/TableAlgorithms")
AMLookAt = AMLookAt or class(CoreActionElement)
function AMLookAt.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMLookAt.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15
	L1_4 = managers
	L1_4 = L1_4.player
	L1_4 = L1_4.players
	L1_4 = L1_4(L2_5)
	A0_3.relative_fov = L2_5
	for L5_8, L6_9 in L2_5(L3_6) do
		if L7_10 then
			if L7_10 then
				if L7_10 > 0 then
					for L10_13, L11_14 in L7_10(L8_11) do
						L12_15 = managers
						L12_15 = L12_15.unit_scripting
						L12_15 = L12_15.get_unit_by_name
						L12_15 = L12_15(L12_15, L11_14.script_name)
						if alive(L12_15) then
							L6_9:drama():set_next_look_at_unit(L12_15, A0_3.timer, A0_3.relative_fov)
						end
					end
				end
			else
				L10_13 = A0_3.timer
				L11_14 = A0_3.relative_fov
				L7_10(L8_11, L9_12, L10_13, L11_14)
			end
		end
	end
	L2_5(L3_6)
end
