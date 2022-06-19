require("viewport/HorizontalViewportSplitter")
require("viewport/VerticalViewportSplitter")
require("viewport/SplittableViewport")
if not SplittableViewportManager then
	SplittableViewportManager = class()
end
SplittableViewportManager.init = function(l_1_0)
	l_1_0._splittable_viewports = {}
	l_1_0._split_horizontally = tweak_data.player.camera.split_screen_horizontal
	l_1_0._splitter = l_1_0:_create_splitter()
end

SplittableViewportManager.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in ipairs(l_2_0._splittable_viewports) do
		i_1:destroy()
	end
end

SplittableViewportManager.create_splittable_viewport = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = SplittableViewport:new(l_3_1)
	l_3_3.rectangle.right = 1
	l_3_3.rectangle.bottom = 1
	l_3_0._splittable_viewports[l_3_2] = l_3_3
	l_3_0:layout_viewports(l_3_2)
	return l_3_3
end

SplittableViewportManager.layout_viewports = function(l_4_0, l_4_1)
	local l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15 = nil
	l_4_0._splitter = l_4_0:_create_splitter()
	local l_4_2 = #l_4_0._splittable_viewports
	for i_0,i_1 in pairs(l_4_0._splittable_viewports) do
		i_1.rectangle = Rectangle:new()
		i_1.rectangle.bottom = 1
		i_1.rectangle.right = 1
	end
	print("Layout Viewports count:", l_4_2)
	if l_4_1 == 1 or l_4_1 == 2 and l_4_2 == 2 then
		l_4_0:_add_left_viewport()
	end
	if l_4_1 == 2 or l_4_1 == 1 and l_4_2 == 2 then
		l_4_0:_add_right_viewport()
	end
	l_4_0:_adjust_viewport_size_and_pos()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SplittableViewportManager._add_left_viewport = function(l_5_0)
	l_5_0._splitter:add_left_viewport(l_5_0._splittable_viewports[1])
	l_5_0._splitter:set_target_position(1)
	l_5_0._splitter:set_position(1)
end

SplittableViewportManager._add_right_viewport = function(l_6_0)
	l_6_0._splitter:add_right_viewport(l_6_0._splittable_viewports[2])
	l_6_0._splitter:set_target_position(0.5)
end

SplittableViewportManager.destroy_viewport = function(l_7_0, l_7_1, l_7_2)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11 = nil
	assert(l_7_1)
	l_7_0._splitter:remove_viewport(l_7_1)
	local l_7_3 = nil
	for i_0,i_1 in ipairs(l_7_0._splittable_viewports) do
		if not l_7_3 and i_1 == l_7_1 then
			l_7_3 = true
		end
		if l_7_3 then
			l_7_0._splittable_viewports[i_0] = l_7_0._splittable_viewports[i_0 + 1]
		end
	end
	l_7_1:destroy()
	l_7_0:layout_viewports()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SplittableViewportManager.update = function(l_8_0, l_8_1)
	if Application:debug_build() then
		l_8_0:_adjust_viewport_size_and_pos()
	end
	l_8_0._splitter:update(l_8_1)
	l_8_0:update_viewports()
end

SplittableViewportManager.render = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	if script_debug.render_world then
		for i_0,i_1 in ipairs(l_9_0._splittable_viewports) do
			i_1:render()
		end
	end
end

SplittableViewportManager.update_viewports = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7 = nil
	for i_0,i_1 in ipairs(l_10_0._splittable_viewports) do
		i_1:update()
	end
end

SplittableViewportManager._adjust_viewport_size_and_pos = function(l_11_0)
	local l_11_1 = #l_11_0._splittable_viewports
	local l_11_2 = 0
	local l_11_3 = 0
	if l_11_1 > 1 then
		l_11_3 = tweak_data.player.camera.split_screen_viewport_spacing * 8 / (Application:screen_resolution().y * 0.5)
	end
	l_11_0._splitter:set_offset(l_11_2)
	l_11_0._splitter:set_spacing(l_11_3)
end

SplittableViewportManager._create_splitter = function(l_12_0)
	if l_12_0._split_horizontally then
		local l_12_1, l_12_2 = HorizontalViewportSplitter:new, HorizontalViewportSplitter
		return l_12_1(l_12_2)
	else
		local l_12_3, l_12_4 = VerticalViewportSplitter:new, VerticalViewportSplitter
		return l_12_3(l_12_4)
	end
end


