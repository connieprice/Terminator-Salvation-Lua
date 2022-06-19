if not CoreEditableGui then
	CoreEditableGui = class()
end
CoreEditableGui.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._text = l_1_0._text or "Default Text"
	l_1_0._cull_distance = l_1_0._cull_distance or 5000
	l_1_0._sides = l_1_0._sides or 1
	l_1_0._gui_movie = l_1_0._gui_movie or "default_text"
	l_1_0._gui_object = l_1_0._gui_object or "gui_name"
	l_1_0._font = l_1_0._font or "diesel"
	l_1_0._gui = World:newgui()
	l_1_0._gui:preload_font(l_1_0._font)
	l_1_0._guis = {}
	if l_1_0._sides == 1 then
		l_1_0:add_workspace(l_1_0._unit:get_object(l_1_0._gui_object))
	else
		for l_1_5 = 1, l_1_0._sides do
			l_1_0:add_workspace(l_1_0._unit:get_object(l_1_0._gui_object .. l_1_5))
		end
	end
	local l_1_6 = l_1_0._guis[1].gui:child("std_text")
	l_1_0._font_size = l_1_6:font_size()
	l_1_0:set_font_size(l_1_0._font_size)
	l_1_0._font_color = Vector3(l_1_6:color().red, l_1_6:color().green, l_1_6:color().blue)
end

CoreEditableGui.add_workspace = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._gui:create_object_workspace(0, 0, l_2_1, Vector3(0, 0, 0))
	local l_2_3 = l_2_2:panel():gui("core_editable_gui")
	local l_2_4 = l_2_3:panel()
	l_2_3:child("std_text"):set_font(l_2_0._font)
	l_2_3:child("std_text"):set_text(l_2_0._text)
	local l_2_5 = table.insert
	local l_2_6 = l_2_0._guis
	local l_2_7 = {}
	l_2_7.workspace = l_2_2
	l_2_7.gui = l_2_3
	l_2_7.panel = l_2_4
	l_2_5(l_2_6, l_2_7)
end

CoreEditableGui.text = function(l_3_0)
	return l_3_0._text
end

CoreEditableGui.set_text = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	l_4_0._text = l_4_1
	for i_0,i_1 in ipairs(l_4_0._guis) do
		i_1.gui:child("std_text"):set_text(l_4_0._text)
	end
end

CoreEditableGui.font_size = function(l_5_0)
	return l_5_0._font_size
end

CoreEditableGui.set_font_size = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10 = nil
	l_6_0._font_size = l_6_1
	for i_0,i_1 in ipairs(l_6_0._guis) do
		i_1.gui:child("std_text"):set_font_size(l_6_0._font_size * (10 * i_1.gui:child("std_text"):height() / 100))
	end
end

CoreEditableGui.font_color = function(l_7_0)
	return l_7_0._font_color
end

CoreEditableGui.set_font_color = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	l_8_0._font_color = l_8_1
	for i_0,i_1 in ipairs(l_8_0._guis) do
		i_1.gui:child("std_text"):set_color(Color(1, l_8_1.x, l_8_1.y, l_8_1.z))
	end
end

CoreEditableGui.lock_gui = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11 = nil
	for i_0,i_1 in ipairs(l_9_0._guis) do
		i_1.workspace:set_cull_distance(l_9_0._cull_distance)
		i_1.workspace:set_frozen(true)
	end
end

CoreEditableGui.destroy = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9 = nil
	for i_0,i_1 in ipairs(l_10_0._guis) do
		if alive(l_10_0._gui) and alive(i_1.workspace) then
			l_10_0._gui:destroy_workspace(i_1.workspace)
		end
	end
	l_10_0._guis = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


