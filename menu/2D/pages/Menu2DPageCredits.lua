require("menu/2D/Menu2DPage")
require("menu/CreditsScroller.lua")
if not Menu2DPageCredits then
	Menu2DPageCredits = class(Menu2DPage)
end
Menu2DPageCredits.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
end

Menu2DPageCredits.update = function(l_2_0, l_2_1)
	Menu2DPage.update(l_2_0, l_2_1)
	if not l_2_0._done then
		l_2_0._credits_scroller:update(l_2_1)
	if l_2_0._credits_scroller:is_done() then
		end
		managers.menu2d:menu_island_instance_data().credits_done = true
		l_2_0._done = true
	end
end

Menu2DPageCredits.input = function(l_3_0, l_3_1, l_3_2)
	if not managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_select") then
		local l_3_3, l_3_4, l_3_5, l_3_6 = managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_start")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_3 then
		l_3_0:exit()
	elseif l_3_1.back then
		l_3_0:exit()
	end
	if l_3_0._done and managers.menu2d:can_go_back() then
		managers.menu2d:back()
	end
	if not l_3_0._done then
		l_3_0._credits_scroller:input_update(l_3_1.move_axis.y)
	end
end

Menu2DPageCredits.open = function(l_4_0, l_4_1, l_4_2, l_4_3)
	Menu2DPage.open(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0._credits_scroller = CreditsScroller:new(l_4_0._panel, "data/gui/end_credits.xml")
	l_4_0._done = false
	managers.menu2d:menu_island_instance_data().credits_done = false
end

Menu2DPageCredits.destroy = function(l_5_0)
	l_5_0._credits_scroller:destroy()
	l_5_0._credits_scroller = nil
	Menu2DPage.destroy(l_5_0)
end

Menu2DPageCredits.credits_done = function(l_6_0)
	return l_6_0._done
end

Menu2DPageCredits.exit = function(l_7_0)
	l_7_0._done = true
end

Menu2DPageCredits.confirm_mode = function(l_8_0)
	local l_8_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_8_1
end


