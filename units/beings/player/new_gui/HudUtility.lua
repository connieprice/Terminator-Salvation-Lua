if not HudUtility then
	HudUtility = {}
end
HudUtility.is_split_screen = function()
	local l_1_0 = managers.player:human_players()
	for i_0,i_1 in pairs(l_1_0) do
		local l_1_2 = 0
		l_1_2 = l_1_2 + 1
	end
	return l_1_2 > 1
end

HudUtility.hide_panel = function(l_2_0, l_2_1)
	if alive(l_2_0) then
		HudUtility.hide_children(l_2_0:children(), l_2_1)
	end
end

HudUtility.hide_children = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20, l_3_21, l_3_22, l_3_23, l_3_24 = nil
	for i_0,i_1 in pairs(l_3_0) do
		if alive(i_1) then
			if l_3_1 and i_1.set_color then
				i_1:set_color(i_1:color():with_alpha(0))
			end
			do return end
			i_1:hide()
		if i_1.children then
			end
			HudUtility.hide_children(i_1:children(), l_3_1)
		end
	end
end

HudUtility.show_debug_frame = function(l_4_0, l_4_1)
	local l_4_2 = {}
	table.insert(l_4_2, Vector3(0, 0, 0))
	table.insert(l_4_2, Vector3(0, l_4_0:height(), 0))
	table.insert(l_4_2, Vector3(l_4_0:width(), l_4_0:height(), 0))
	table.insert(l_4_2, Vector3(l_4_0:width(), 0, 0))
	table.insert(l_4_2, Vector3(0, 0, 0))
	local l_4_3, l_4_4 = l_4_0:polyline, l_4_0
	local l_4_5 = {}
	l_4_5.name = "debug_frame"
	l_4_3 = l_4_3(l_4_4, l_4_5)
	l_4_4, l_4_5 = l_4_3:set_color, l_4_3
	l_4_4(l_4_5, l_4_1)
	l_4_4, l_4_5 = l_4_3:set_points, l_4_3
	l_4_4(l_4_5, l_4_2)
end


