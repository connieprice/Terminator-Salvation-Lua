Menu2DDebug = Menu2DDebug or class()
function Menu2DDebug._profile(A0_0)
	return managers.menu_input:bound_user() and managers.menu_input:bound_user():is_profile_ready() and managers.menu_input:bound_user():profile()
end
function Menu2DDebug.unlock_levels(A0_1, A1_2, A2_3)
	local L3_4
	A1_2 = A1_2 or 1
	A2_3 = A2_3 or 18
	L3_4 = A0_1._profile
	L3_4 = L3_4(A0_1)
	assert(L3_4)
	for _FORV_7_ = A1_2, A2_3 do
		L3_4.levels[_FORV_7_].maximum_checkpoint_id = 1
	end
	L3_4.has_progress = true
	managers.save:primary_user():save_profile()
end
function Menu2DDebug.callback_create_levels_page(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10, L6_11
	L3_8(L4_9)
	L6_11 = L4_9(L5_10)
	for L6_11, 