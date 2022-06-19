if not MenuTrigger then
	MenuTrigger = class(CoreTriggerBase)
end
MenuTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	managers.menu_trigger:add_menu_trigger(l_1_0)
end

MenuTrigger.destroy = function(l_2_0)
	managers.menu_trigger:remove_menu_trigger(l_2_0._mode)
end

MenuTrigger.menu_changed = function(l_3_0, l_3_1)
	if l_3_1 == "mainmenu_to_difficulty_level" then
		l_3_0._user:trigger_activated(l_3_0._id, 1)
	elseif l_3_1 == "difficulty_level_to_mainmenu" then
		l_3_0._user:trigger_activated(l_3_0._id, 2)
	elseif l_3_1 == "mainmenu_to_checkpoints" then
		l_3_0._user:trigger_activated(l_3_0._id, 3)
	elseif l_3_1 == "checkpoints_to_mainmenu" then
		l_3_0._user:trigger_activated(l_3_0._id, 4)
	elseif l_3_1 == "mainmenu_to_options" then
		l_3_0._user:trigger_activated(l_3_0._id, 5)
	elseif l_3_1 == "options_to_mainmenu" then
		l_3_0._user:trigger_activated(l_3_0._id, 6)
	elseif l_3_1 == "difficulty_level_to_mode_select" then
		l_3_0._user:trigger_activated(l_3_0._id, 7)
	elseif l_3_1 == "mode_select_to_difficulty_level" then
		l_3_0._user:trigger_activated(l_3_0._id, 8)
	end
end


