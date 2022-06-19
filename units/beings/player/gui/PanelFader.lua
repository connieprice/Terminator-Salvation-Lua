require("shared/Interpolator")
if not PanelFader then
	PanelFader = class()
end
PanelFader.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = 0
	if l_1_2 then
		l_1_4 = l_1_2
	end
	if not l_1_3 then
		l_1_3 = 100
	end
	l_1_0._alpha = Interpolator:new(l_1_4, l_1_3)
	l_1_0._panel = l_1_1
end

PanelFader.update = function(l_2_0, l_2_1)
	l_2_0._alpha:update(l_2_1)
	local l_2_2 = l_2_0._alpha:value()
	l_2_0:_fade_children(l_2_0._panel:children(), l_2_2)
end

PanelFader._fade_children = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19 = nil
	for i_0,i_1 in pairs(l_3_1) do
		if i_1.set_color then
			i_1:set_color(i_1:color():with_alpha(l_3_2))
		end
		if i_1.children then
			l_3_0:_fade_children(i_1:children(), l_3_2)
		end
	end
end

PanelFader.has_reached_target = function(l_4_0)
	local l_4_1, l_4_2 = l_4_0._alpha:has_reached_target, l_4_0._alpha
	return l_4_1(l_4_2)
end

PanelFader.set_target = function(l_5_0, l_5_1)
	l_5_0._alpha:set_target(l_5_1)
end

PanelFader.set_speed = function(l_6_0, l_6_1)
	l_6_0._alpha:set_speed(l_6_1)
end


