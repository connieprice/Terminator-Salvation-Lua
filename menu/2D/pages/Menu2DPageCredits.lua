require("menu/2D/Menu2DPage")
require("menu/CreditsScroller.lua")
Menu2DPageCredits = Menu2DPageCredits or class(Menu2DPage)
function Menu2DPageCredits.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
end
function Menu2DPageCredits.update(A0_3, A1_4)
	Menu2DPage.update(A0_3, A1_4)
	if not A0_3._done then
		A0_3._credits_scroller:update(A1_4)
		if A0_3._credits_scroller:is_done() then
			managers.menu2d:menu_island_instance_data().credits_done = true
			A0_3._done = true
		end
	end
end
function Menu2DPageCredits.input(A0_5, A1_6, A2_7)
	if managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_select") or managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_start") then
		A0_5:exit()
	elseif A1_6.back then
		A0_5:exit()
	end
	if A0_5._done and managers.menu2d:can_go_back() then
		managers.menu2d:back()
	end
	if not A0_5._done then
		A0_5._credits_scroller:input_update(A1_6.move_axis.y)
	end
end
function Menu2DPageCredits.open(A0_8, A1_9, A2_10, A3_11)
	Menu2DPage.open(A0_8, A1_9, A2_10, A3_11)
	A0_8._credits_scroller = CreditsScroller:new(A0_8._panel, "data/gui/end_credits.xml")
	A0_8._done = false
	managers.menu2d:menu_island_instance_data().credits_done = false
end
function Menu2DPageCredits.destroy(A0_12)
	A0_12._credits_scroller:destroy()
	A0_12._credits_scroller = nil
	Menu2DPage.destroy(A0_12)
end
function Menu2DPageCredits.credits_done(A0_13)
	local L1_14
	L1_14 = A0_13._done
	return L1_14
end
function Menu2DPageCredits.exit(A0_15)
	local L1_16
	A0_15._done = true
end
function Menu2DPageCredits.confirm_mode(A0_17)
	local L1_18
	return L1_18
end
