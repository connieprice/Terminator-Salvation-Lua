if not MenuTriggerManager then
	MenuTriggerManager = class()
end
MenuTriggerManager.init = function(l_1_0)
	l_1_0._menu_triggers = {}
end

MenuTriggerManager.add_menu_trigger = function(l_2_0, l_2_1)
	l_2_0._menu_triggers[l_2_1._mode] = l_2_1
end

MenuTriggerManager.remove_menu_trigger = function(l_3_0, l_3_1)
	l_3_0._menu_triggers[l_3_1._mode] = nil
end

MenuTriggerManager.menu_changed = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = tostring(l_4_1) .. "_to_" .. tostring(l_4_2)
	local l_4_4 = l_4_0._menu_triggers[l_4_3]
	if not l_4_4 then
		return 
	end
	l_4_4:menu_changed(l_4_3)
end


