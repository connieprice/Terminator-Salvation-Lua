require("units/beings/player/gui/TextPanelCreator")
if not HudPlayerObjective then
	HudPlayerObjective = class()
end
HudPlayerObjective.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._panel_creator = l_1_1
	l_1_0._assigned_objective = l_1_2
	l_1_0._use_small_font = l_1_3
	l_1_0:create_panel()
end

HudPlayerObjective.destroy = function(l_2_0)
	if l_2_0._panel then
		l_2_0:_remove_panel()
	end
end

HudPlayerObjective._remove_panel = function(l_3_0)
	assert(l_3_0._panel)
	l_3_0._panel_creator:remove_hud_panel(l_3_0._panel)
	l_3_0._panel = nil
end

HudPlayerObjective.create_panel = function(l_4_0)
	local l_4_1, l_4_2 = nil, nil
	if l_4_0._assigned_objective:is_completed() then
		l_4_1 = "[mission_objectivebox_completed] "
		l_4_2 = "_completed"
	else
		l_4_1 = "[mission_objectivebox_not_completed] "
		l_4_2 = "_started"
	end
	if not l_4_0._assigned_objective:objective():time() or l_4_0._is_completed or Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2).format(Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2), l_4_0._assigned_objective:timer():time_left()) == l_4_0._old_str then
		return 
	end
	if l_4_0._panel then
		l_4_0:_remove_panel()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_4_0.text_panel_creator = TextPanelCreator:new(l_4_0._panel_creator, l_4_1 .. Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2).format(Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2), l_4_0._assigned_objective:timer():time_left()), Color(1, 1, 1, 1), l_4_0._use_small_font, true)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_4_0._old_str = Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2).format(Localizer:lookup(l_4_0._assigned_objective:objective():text_id() .. l_4_2), l_4_0._assigned_objective:timer():time_left())
	l_4_0._panel = l_4_0.text_panel_creator:panel()
end

HudPlayerObjective.update = function(l_5_0)
	l_5_0:create_panel()
end

HudPlayerObjective.update_icon_pulse = function(l_6_0, l_6_1)
	if l_6_0.text_panel_creator then
		l_6_0.text_panel_creator:update_icon_pulse(l_6_1)
	end
end

HudPlayerObjective.update_mover = function(l_7_0, l_7_1)
	if l_7_0.text_panel_creator then
		l_7_0.text_panel_creator:update_mover(l_7_1)
	end
end


