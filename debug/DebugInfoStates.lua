if not DebugInfoStates then
	DebugInfoStates = class()
end
DebugInfoStates.init = function(l_1_0, l_1_1)
	l_1_0._panel = l_1_1
end

DebugInfoStates._add_user = function(l_2_0, l_2_1, l_2_2)
	if l_2_2 then
		local l_2_3, l_2_4, l_2_5 = "User" .. l_2_2:user_index()
	else
		l_2_0:_add_state_text(l_2_1, "<nil>")
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 9 
end

DebugInfoStates._add_state_text = function(l_3_0, l_3_1, l_3_2)
	local l_3_3, l_3_4 = l_3_0._panel:text, l_3_0._panel
	local l_3_5 = {}
	l_3_5.font = "diesel"
	l_3_5.text = l_3_1 .. ": " .. l_3_2
	l_3_5.y = l_3_0._y
	l_3_5.x = 10
	l_3_3(l_3_4, l_3_5)
	l_3_3 = l_3_0._y
	l_3_3 = l_3_3 + 15
	l_3_0._y = l_3_3
end

DebugInfoStates._space = function(l_4_0)
	l_4_0._y = l_4_0._y + 10
end

DebugInfoStates.update = function(l_5_0, l_5_1)
	l_5_0._panel:clear()
	l_5_0._y = 4
	l_5_0:_add_state_text("Game", managers.game._state:_debug_state_name())
	l_5_0:_add_state_text("  Freeze", managers.game._freeze_state:_debug_state_name())
	l_5_0:_add_user("Primary", managers.save:primary_user())
	l_5_0:_space()
	l_5_0:_add_state_text("Menu", managers.menu._machine:_debug_state_name())
	l_5_0:_add_state_text("  Dialog", managers.menu._dialog_state:_debug_state_name())
	l_5_0:_add_user("    Dialog-User", managers.menu._dialog_local_user)
	l_5_0:_space()
	l_5_0:_add_state_text("Menu2D main", managers.menu2d._menu_state_machine:_debug_state_name())
	local l_5_2 = ""
	local l_5_3 = managers.menu2d._menu_state_machine._state._sub_state_machine
	if l_5_3 then
		l_5_2 = l_5_3:_debug_state_name()
	end
	l_5_0:_add_state_text("Menu2D sub state 1", l_5_2)
	l_5_0:_space()
	local l_5_8, l_5_9 = l_5_0:_add_user, l_5_0
	l_5_8(l_5_9, "Input", managers.menu_input:bound_user())
	l_5_8 = managers
	l_5_8 = l_5_8.local_user
	l_5_8, l_5_9 = l_5_8:users, l_5_8
	l_5_8 = l_5_8(l_5_9)
	local l_5_4 = nil
	l_5_9 = pairs
	l_5_4 = l_5_8
	l_5_9 = l_5_9(l_5_4)
	for i_0,i_1 in l_5_9 do
		local l_5_10 = "User" .. l_5_7:user_index()
		l_5_0:_space()
		l_5_0:_add_state_text(l_5_10 .. " SignIn", l_5_7._signin._state:_debug_state_name())
		l_5_0:_add_state_text(l_5_10 .. " Storage", l_5_7._storage._state:_debug_state_name())
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


