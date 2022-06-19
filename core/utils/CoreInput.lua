core:module("CoreInput")
core:require_module("CoreClass")
function shift()
	return Input:keyboard():down("left shift") or Input:keyboard():down("right shift")
end
function ctrl()
	return Input:keyboard():down("left ctrl") or Input:keyboard():down("right ctrl")
end
function alt()
	return Input:keyboard():down("left alt")
end
RepKey = RepKey or CoreClass.class()
function RepKey.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._keys = A1_1 or {}
	A0_0._current_time = 0
	A0_0._current_rep_time = 0
	A0_0._pause = A2_2 or 0.5
	A0_0._rep = A3_3 or 0.1
	A0_0._input = Input:keyboard()
end
function RepKey.set_input(A0_4, A1_5)
	A0_4._input = A1_5
end
function RepKey.update(A0_6, A1_7, A2_8)
	local L3_9, L4_10, L5_11, L6_12, L7_13, L8_14
	L3_9 = false
	for L7_13, L8_14 in L4_10(L5_11) do
		if A0_6._input:down(L8_14) then
			L3_9 = true
		else
		end
	end
	if L3_9 then
		if L5_11 >= L6_12 then
			if L5_11 >= L6_12 then
				A0_6._current_rep_time = 0
			else
				A0_6._current_rep_time = L5_11
			end
		else
			A0_6._current_time = L5_11
		end
	else
		A0_6._current_time = 0
		A0_6._current_rep_time = 0
	end
	return L4_10
end
