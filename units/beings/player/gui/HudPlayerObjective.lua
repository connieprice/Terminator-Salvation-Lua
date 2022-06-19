require("units/beings/player/gui/TextPanelCreator")
HudPlayerObjective = HudPlayerObjective or class()
function HudPlayerObjective.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._panel_creator = A1_1
	A0_0._assigned_objective = A2_2
	A0_0._use_small_font = A3_3
	A0_0:create_panel()
end
function HudPlayerObjective.destroy(A0_4)
	if A0_4._panel then
		A0_4:_remove_panel()
	end
end
function HudPlayerObjective._remove_panel(A0_5)
	assert(A0_5._panel)
	A0_5._panel_creator:remove_hud_panel(A0_5._panel)
	A0_5._panel = nil
end
function HudPlayerObjective.create_panel(A0_6)
	local L1_7, L2_8, L3_9
	L3_9 = A0_6._assigned_objective
	L3_9 = L3_9.is_completed
	L3_9 = L3_9(L3_9)
	if L3_9 then
		L1_7 = "[mission_objectivebox_completed] "
		L2_8 = "_completed"
	else
		L1_7 = "[mission_objectivebox_not_completed] "
		L2_8 = "_started"
	end
	L3_9 = Localizer
	L3_9 = L3_9.lookup
	L3_9 = L3_9(L3_9, A0_6._assigned_objective:objective():text_id() .. L2_8)
	if A0_6._assigned_objective:objective():time() and not A0_6._is_completed then
		L3_9 = L3_9.format(L3_9, A0_6._assigned_objective:timer():time_left())
	end
	if L3_9 == A0_6._old_str then
		return
	end
	if A0_6._panel then
		A0_6:_remove_panel()
	end
	A0_6.text_panel_creator = TextPanelCreator:new(A0_6._panel_creator, L1_7 .. L3_9, Color(1, 1, 1, 1), A0_6._use_small_font, true)
	A0_6._old_str = L3_9
	A0_6._panel = A0_6.text_panel_creator:panel()
end
function HudPlayerObjective.update(A0_10)
	A0_10:create_panel()
end
function HudPlayerObjective.update_icon_pulse(A0_11, A1_12)
	if A0_11.text_panel_creator then
		A0_11.text_panel_creator:update_icon_pulse(A1_12)
	end
end
function HudPlayerObjective.update_mover(A0_13, A1_14)
	if A0_13.text_panel_creator then
		A0_13.text_panel_creator:update_mover(A1_14)
	end
end
