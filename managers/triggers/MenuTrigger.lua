MenuTrigger = MenuTrigger or class(CoreTriggerBase)
function MenuTrigger.init(A0_0, A1_1, A2_2, A3_3)
	CoreTriggerBase.init(A0_0, A1_1, A2_2, A3_3)
	managers.menu_trigger:add_menu_trigger(A0_0)
end
function MenuTrigger.destroy(A0_4)
	managers.menu_trigger:remove_menu_trigger(A0_4._mode)
end
function MenuTrigger.menu_changed(A0_5, A1_6)
	if A1_6 == "mainmenu_to_difficulty_level" then
		A0_5._user:trigger_activated(A0_5._id, 1)
	elseif A1_6 == "difficulty_level_to_mainmenu" then
		A0_5._user:trigger_activated(A0_5._id, 2)
	elseif A1_6 == "mainmenu_to_checkpoints" then
		A0_5._user:trigger_activated(A0_5._id, 3)
	elseif A1_6 == "checkpoints_to_mainmenu" then
		A0_5._user:trigger_activated(A0_5._id, 4)
	elseif A1_6 == "mainmenu_to_options" then
		A0_5._user:trigger_activated(A0_5._id, 5)
	elseif A1_6 == "options_to_mainmenu" then
		A0_5._user:trigger_activated(A0_5._id, 6)
	elseif A1_6 == "difficulty_level_to_mode_select" then
		A0_5._user:trigger_activated(A0_5._id, 7)
	elseif A1_6 == "mode_select_to_difficulty_level" then
		A0_5._user:trigger_activated(A0_5._id, 8)
	end
end
