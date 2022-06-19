require("shared/Rectangle")
if not SplittableViewport then
	SplittableViewport = class()
end
SplittableViewport.init = function(l_1_0)
	l_1_0:set_world()
	l_1_0.rectangle = Rectangle:new()
end

SplittableViewport.destroy = function(l_2_0)
	if l_2_0._script_vp and l_2_0._script_vp:alive() then
		l_2_0:release_engine_viewport()
	end
	if l_2_0._engine_camera then
		World:delete_camera(l_2_0._engine_camera)
		l_2_0._engine_camera = nil
	end
end

SplittableViewport.engine_camera = function(l_3_0)
	return l_3_0._engine_camera
end

SplittableViewport.get_engine_viewport = function(l_4_0)
	return l_4_0.engine_viewport
end

SplittableViewport.script_viewport = function(l_5_0)
	return l_5_0._script_vp
end

SplittableViewport.create_engine_camera = function(l_6_0)
	l_6_0._init_fov = tweak_data.player.camera.FOV_STD
	l_6_0._init_near_range = tweak_data.player.camera.NEAR_RANGE_STD
	l_6_0._init_far_range = tweak_data.player.camera.FAR_RANGE_STD
	l_6_0._input_value = 1
	l_6_0._engine_camera = World:create_camera()
	l_6_0._engine_camera:set_position(Vector3(0, 0, 0))
	l_6_0._engine_camera:new_set_rotation(Rotation())
	l_6_0._engine_camera:set_fov(l_6_0._init_fov)
	l_6_0._engine_camera:set_near_range(l_6_0._init_near_range)
	l_6_0._engine_camera:set_far_range(l_6_0._init_far_range)
	l_6_0.engine_viewport:set_camera(l_6_0._engine_camera)
	l_6_0._script_vp:set_active(true)
end

SplittableViewport.release_engine_viewport = function(l_7_0)
	cat_print("debug", "Destroying engine viewport")
	l_7_0._script_vp:destroy()
	l_7_0.engine_viewport = nil
end

SplittableViewport.set_world = function(l_8_0)
	if l_8_0._script_vp and l_8_0._script_vp:alive() then
		l_8_0:release_engine_viewport()
	end
	local l_8_1 = nil
	l_8_0._script_vp = EnvironmentScriptViewport:new(0, 0, 0, 0)
	l_8_1 = l_8_0._script_vp:vp()
	l_8_0.engine_viewport = l_8_1
	l_8_0:create_engine_camera()
	local l_8_2 = managers.worldcamera:current_world_camera()
	if l_8_2 then
		managers.viewport:pop()
		managers.worldcamera:viewport():set_active(false)
		managers.viewport:push()
		managers.viewport:deactivate_all_viewports()
		managers.worldcamera:viewport():set_active(true)
	end
end

SplittableViewport.update = function(l_9_0)
end

SplittableViewport.render = function(l_10_0)
	if not alive(l_10_0._engine_camera) then
		l_10_0._engine_camera = nil
	end
	l_10_0.engine_viewport:set_dimensions(l_10_0.rectangle.left, l_10_0.rectangle.top, l_10_0.rectangle:width(), l_10_0.rectangle:height())
end

SplittableViewport.rectangle = function(l_11_0)
	return l_11_0.rectangle
end

SplittableViewport.render_world_and_underlay = function(l_12_0)
	if not l_12_0._engine_camera then
		return 
	end
	local l_12_1 = nil
	if l_12_0.rectangle:height() < 0.01 then
		l_12_1 = 1
	else
		l_12_1 = l_12_0.rectangle:width() / l_12_0.rectangle:height()
	end
	l_12_0._engine_camera:set_width_multiplier(width_mul() * (l_12_1))
	Application:render("World", l_12_0.engine_viewport, nil, "Underlay", l_12_0.engine_viewport)
end


