require("shared/Rectangle")
SplittableViewport = SplittableViewport or class()
function SplittableViewport.init(A0_0)
	A0_0:set_world()
	A0_0.rectangle = Rectangle:new()
end
function SplittableViewport.destroy(A0_1)
	if A0_1._script_vp and A0_1._script_vp:alive() then
		A0_1:release_engine_viewport()
	end
	if A0_1._engine_camera then
		World:delete_camera(A0_1._engine_camera)
		A0_1._engine_camera = nil
	end
end
function SplittableViewport.engine_camera(A0_2)
	local L1_3
	L1_3 = A0_2._engine_camera
	return L1_3
end
function SplittableViewport.get_engine_viewport(A0_4)
	local L1_5
	L1_5 = A0_4.engine_viewport
	return L1_5
end
function SplittableViewport.script_viewport(A0_6)
	local L1_7
	L1_7 = A0_6._script_vp
	return L1_7
end
function SplittableViewport.create_engine_camera(A0_8)
	A0_8._init_fov = tweak_data.player.camera.FOV_STD
	A0_8._init_near_range = tweak_data.player.camera.NEAR_RANGE_STD
	A0_8._init_far_range = tweak_data.player.camera.FAR_RANGE_STD
	A0_8._input_value = 1
	A0_8._engine_camera = World:create_camera()
	A0_8._engine_camera:set_position(Vector3(0, 0, 0))
	A0_8._engine_camera:new_set_rotation(Rotation())
	A0_8._engine_camera:set_fov(A0_8._init_fov)
	A0_8._engine_camera:set_near_range(A0_8._init_near_range)
	A0_8._engine_camera:set_far_range(A0_8._init_far_range)
	A0_8.engine_viewport:set_camera(A0_8._engine_camera)
	A0_8._script_vp:set_active(true)
end
function SplittableViewport.release_engine_viewport(A0_9)
	cat_print("debug", "Destroying engine viewport")
	A0_9._script_vp:destroy()
	A0_9.engine_viewport = nil
end
function SplittableViewport.set_world(A0_10)
	local L1_11
	L1_11 = A0_10._script_vp
	if L1_11 then
		L1_11 = A0_10._script_vp
		L1_11 = L1_11.alive
		L1_11 = L1_11(L1_11)
		if L1_11 then
			L1_11 = A0_10.release_engine_viewport
			L1_11(A0_10)
		end
	end
	L1_11 = nil
	A0_10._script_vp = EnvironmentScriptViewport:new(0, 0, 0, 0)
	L1_11 = A0_10._script_vp:vp()
	A0_10.engine_viewport = L1_11
	A0_10:create_engine_camera()
	if managers.worldcamera:current_world_camera() then
		managers.viewport:pop()
		managers.worldcamera:viewport():set_active(false)
		managers.viewport:push()
		managers.viewport:deactivate_all_viewports()
		managers.worldcamera:viewport():set_active(true)
	end
end
function SplittableViewport.update(A0_12)
	local L1_13
end
function SplittableViewport.render(A0_14)
	if not alive(A0_14._engine_camera) then
		A0_14._engine_camera = nil
	end
	A0_14.engine_viewport:set_dimensions(A0_14.rectangle.left, A0_14.rectangle.top, A0_14.rectangle:width(), A0_14.rectangle:height())
end
function SplittableViewport.rectangle(A0_15)
	local L1_16
	L1_16 = A0_15.rectangle
	return L1_16
end
function SplittableViewport.render_world_and_underlay(A0_17)
	local L1_18
	L1_18 = A0_17._engine_camera
	if not L1_18 then
		return
	end
	L1_18 = nil
	if A0_17.rectangle:height() < 0.01 then
		L1_18 = 1
	else
		L1_18 = A0_17.rectangle:width() / A0_17.rectangle:height()
	end
	A0_17._engine_camera:set_width_multiplier(width_mul() * L1_18)
	Application:render("World", A0_17.engine_viewport, nil, "Underlay", A0_17.engine_viewport)
end
