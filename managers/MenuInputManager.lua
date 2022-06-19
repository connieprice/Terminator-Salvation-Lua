if not MenuInputManager then
	MenuInputManager = class()
end
MenuInputManager.init = function(l_1_0, l_1_1)
	if not l_1_1.user_index then
		return 
	end
	l_1_0._bound_user = managers.local_user:user_from_user_index(l_1_1.user_index)
	assert(l_1_0._bound_user)
end

MenuInputManager.default_data = function(l_2_0)
	l_2_0.user_index = nil
end

MenuInputManager.save = function(l_3_0, l_3_1)
	assert(l_3_0._bound_user)
	l_3_1.user_index = l_3_0._bound_user:user_index()
	assert(l_3_1.user_index)
end

MenuInputManager.any_user_pressed = function(l_4_0, l_4_1, l_4_2)
	local l_4_6, l_4_7, l_4_8, l_4_9 = nil
	for i_0,i_1 in pairs(l_4_1) do
		if i_1:controller_wrapper():get_input_pressed(l_4_2) then
			return i_1
		end
		if l_4_0:_backup_controller(i_1) and l_4_0:_backup_controller(i_1):get_input_pressed(l_4_2) then
			return l_4_11
		end
	end
end

local l_0_0 = "pc"
end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

 -- WARNING: undefined locals caused missing assignments!

