DebugInfoStates = DebugInfoStates or class()
function DebugInfoStates.init(A0_0, A1_1)
	A0_0._panel = A1_1
end
function DebugInfoStates._add_user(A0_2, A1_3, A2_4)
	local L3_5
	if A2_4 then
		L3_5 = "User" .. A2_4:user_index()
	else
		L3_5 = "<nil>"
	end
	A0_2:_add_state_text(A1_3, L3_5)
end
function DebugInfoStates._add_state_text(A0_6, A1_7, A2_8)
	A0_6._panel:text({
		font = "diesel",
		text = A1_7 .. ": " .. A2_8,
		y = A0_6._y,
		x = 10
	})
	A0_6._y = A0_6._y + 15
end
function DebugInfoStates._space(A0_9)
	local L1_10
	L1_10 = A0_9._y
	L1_10 = L1_10 + 10
	A0_9._y = L1_10
end
function DebugInfoStates.update(A0_11, A1_12)
	local L2_13, L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21
	L2_13 = A0_11._panel
	L3_14 = L2_13
	L2_13 = L2_13.clear
	L2_13(L3_14)
	A0_11._y = 4
	L3_14 = A0_11
	L2_13 = A0_11._add_state_text
	L4_15 = "Game"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L3_14 = A0_11
	L2_13 = A0_11._add_state_text
	L4_15 = "  Freeze"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L3_14 = A0_11
	L2_13 = A0_11._add_user
	L4_15 = "Primary"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L3_14 = A0_11
	L2_13 = A0_11._space
	L2_13(L3_14)
	L3_14 = A0_11
	L2_13 = A0_11._add_state_text
	L4_15 = "Menu"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L3_14 = A0_11
	L2_13 = A0_11._add_state_text
	L4_15 = "  Dialog"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L3_14 = A0_11
	L2_13 = A0_11._add_user
	L4_15 = "    Dialog-User"
	L2_13(L3_14, L4_15, L5_16)
	L3_14 = A0_11
	L2_13 = A0_11._space
	L2_13(L3_14)
	L3_14 = A0_11
	L2_13 = A0_11._add_state_text
	L4_15 = "Menu2D main"
	L10_21 = L5_16(L6_17)
	L2_13(L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L5_16(L6_17))
	L2_13 = ""
	L3_14 = managers
	L3_14 = L3_14.menu2d
	L3_14 = L3_14._menu_state_machine
	L3_14 = L3_14._state
	L3_14 = L3_14._sub_state_machine
	if L3_14 then
		L4_15 = L3_14._debug_state_name
		L4_15 = L4_15(L5_16)
		L2_13 = L4_15
	end
	L4_15 = A0_11._add_state_text
	L4_15(L5_16, L6_17, L7_18)
	L4_15 = A0_11._space
	L4_15(L5_16)
	L4_15 = A0_11._add_user
	L8_19 = L7_18
	L10_21 = L7_18(L8_19)
	L4_15(L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L7_18(L8_19))
	L4_15 = managers
	L4_15 = L4_15.local_user
	L4_15 = L4_15.users
	L4_15 = L4_15(L5_16)
	for L8_19, L9_20 in L5_16(L6_17) do
		L10_21 = "User"
		L10_21 = L10_21 .. L9_20:user_index()
		A0_11:_space()
		A0_11:_add_state_text(L10_21 .. " SignIn", L9_20._signin._state:_debug_state_name())
		A0_11:_add_state_text(L10_21 .. " Storage", L9_20._storage._state:_debug_state_name())
	end
end
