local L0_0
L0_0 = MenuInputManager
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
MenuInputManager = L0_0
L0_0 = MenuInputManager
function L0_0.init(A0_1, A1_2)
	if not A1_2.user_index then
		return
	end
	A0_1._bound_user = managers.local_user:user_from_user_index(A1_2.user_index)
	assert(A0_1._bound_user)
end
L0_0 = MenuInputManager
function L0_0.default_data(A0_3)
	local L1_4
	A0_3.user_index = nil
end
L0_0 = MenuInputManager
function L0_0.save(A0_5, A1_6)
	assert(A0_5._bound_user)
	A1_6.user_index = A0_5._bound_user:user_index()
	assert(A1_6.user_index)
end
L0_0 = MenuInputManager
function L0_0.any_user_pressed(A0_7, A1_8, A2_9)
	local L3_10, L4_11, L5_12, L6_13, L7_14
	for L6_13, L7_14 in L3_10(L4_11) do
		if L7_14:controller_wrapper():get_input_pressed(A2_9) then
			return L7_14
		end
		if A0_7:_backup_controller(L7_14) and A0_7:_backup_controller(L7_14):get_input_pressed(A2_9) then
			return L7_14
		end
	end
end
L0_0 = "pc"
function MenuInputManager.users_pressing_join(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21
	L1_16 = {}
	for L5_20, L6_21 in L2_17(L3_18) do
		if L6_21:controller_wrapper():get_any_button_pressed_including_unconnected() then
			table.insert(L1_16, L6_21)
		end
	end
	L2_17(L3_18, L4_19)
	return L1_16
end
function MenuInputManager._backup_controller(A0_22, A1_23)
	local L2_24
	if L2_24 == managers.save:primary_user() then
		return L2_24
	end
	if not L2_24 then
		return L2_24
	end
	for 