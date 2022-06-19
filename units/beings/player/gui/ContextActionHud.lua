require("units/beings/player/gui/ContextActionHudStates")
require("units/beings/player/gui/TextPanelCreator")
if not ContextActionHud then
	ContextActionHud = class()
end
ContextActionHud.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._panel_creator = l_1_1
	Localizer:load("data/strings/context_actions.xml")
	l_1_0._alpha = Interpolator:new(0, 10)
	l_1_0._state = FiniteStateMachine:new(l_1_0, "item", ContextActionHudIdle)
	l_1_0._use_timeout = not l_1_2
end

ContextActionHud.update = function(l_2_0, l_2_1)
	l_2_0._state:update(l_2_1)
end

ContextActionHud.display = function(l_3_0, l_3_1, ...)
	assert(l_3_1)
	l_3_0:display_with_color(Localizer:lookup(l_3_1).format(Localizer:lookup(l_3_1), ...))
end

ContextActionHud.display_with_color = function(l_4_0, l_4_1, l_4_2)
	if l_4_0._last_text ~= l_4_1 then
		l_4_0._wants_to_show_new_text = true
	end
	l_4_0._text = l_4_1
	l_4_0._last_text = l_4_0._text
	l_4_0._text_color = l_4_2
end

ContextActionHud.hide = function(l_5_0)
	l_5_0._text = nil
	l_5_0._last_text = nil
	l_5_0._wants_to_show_new_text = false
end

ContextActionHud.wants_to_show_new_text = function(l_6_0)
	return l_6_0._wants_to_show_new_text
end

ContextActionHud.wants_to_hide = function(l_7_0)
	return l_7_0:wants_to_show_new_text() or l_7_0._text == nil
end

ContextActionHud.construct_panel = function(l_8_0)
	if l_8_0._action_panel then
		l_8_0:destroy_panel()
	end
	local l_8_1 = TextPanelCreator:new(l_8_0._panel_creator, l_8_0._text, l_8_0._text_color)
	l_8_0._action_panel = l_8_1:panel()
	l_8_0._wants_to_show_new_text = false
end

ContextActionHud.destroy_panel = function(l_9_0)
	assert(l_9_0._action_panel)
	l_9_0._panel_creator:remove_hud_panel(l_9_0._action_panel)
	l_9_0._action_panel = nil
end


