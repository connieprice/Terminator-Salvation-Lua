require("shared/camera/SharedCamera")
require("shared/Interpolator")
if not DocumentaryCamera then
	DocumentaryCamera = class(SharedCamera)
end
DocumentaryCamera.walk_dir_redirects = {}
DocumentaryCamera.walk_dir_redirects[1] = "walk_fwd"
DocumentaryCamera.walk_dir_redirects[2] = "walk_bwd"
DocumentaryCamera.walk_dir_redirects[3] = "walk_lt"
DocumentaryCamera.walk_dir_redirects[4] = "walk_rt"
DocumentaryCamera.run_dir_redirects = {}
DocumentaryCamera.run_dir_redirects[1] = "run_fwd"
DocumentaryCamera.run_dir_redirects[2] = "run_bwd"
DocumentaryCamera.run_dir_redirects[3] = "run_lt"
DocumentaryCamera.run_dir_redirects[4] = "run_rt"
DocumentaryCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._target_fov = Interpolator:new(0, 4)
	l_1_0._target_shake_amount = Interpolator:new(0, 4)
	l_1_0._player_data = l_1_0._root_unit:player_data()
	l_1_0._damage_data = l_1_0._root_unit:damage_data()
	l_1_0._shake_amount = 0
	l_1_0._cam_settings = tweak_data.player.camera.documentary_camera
end

DocumentaryCamera.destroy = function(l_2_0)
	SharedCamera.destroy(l_2_0)
	if alive(l_2_0._anim_unit) then
		l_2_0._anim_unit:set_slot(0)
		l_2_0._anim_unit = nil
		l_2_0._object = nil
	end
end

DocumentaryCamera.on_activate = function(l_3_0, l_3_1)
	do
		if l_3_1 then
			local l_3_2 = assert
			l_3_2(l_3_0._anim_unit == nil)
			l_3_2 = World
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_0._anim_unit = l_3_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_2(l_3_2, "script")
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_2(l_3_2, false)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_3_2 then
				l_3_0._object = l_3_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				l_3_0._object = l_3_2
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_0._unit_data = l_3_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_0._asm = l_3_2
			l_3_0._shake_amount = 0
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_3_2(l_3_0._anim_unit)
		l_3_0._anim_unit:set_slot(0)
		l_3_0._anim_unit = nil
		l_3_0._object = nil
		l_3_0._unit_data = nil
		l_3_0._asm = nil
	end
end

DocumentaryCamera.parse_parameters = function(l_4_0, l_4_1)
	SharedCamera.parse_parameters(l_4_0, l_4_1)
	if l_4_1.unit then
		l_4_0._anim_unit_name = l_4_1.unit
	end
	if l_4_1.object then
		l_4_0._object_name = l_4_1.object
	end
end

DocumentaryCamera.preload_units = function(l_5_0)
	local l_5_1 = l_5_0.unit
	if l_5_1 then
		World:preload_unit(l_5_1)
	end
end

DocumentaryCamera.update = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	assert(l_6_0._anim_unit)
	local l_6_5 = l_6_0._anim_unit
	local l_6_6 = l_6_0._player_data
	if l_6_6 then
		local l_6_7 = l_6_0._target_fov
		if l_6_6.is_precision_aiming then
			l_6_7:set_target(-10)
		else
			l_6_7:set_target(0)
		end
		l_6_7:update(l_6_2)
		l_6_0._target_shake_amount:update(l_6_2)
		local l_6_8 = l_6_0._target_shake_amount:value()
		if l_6_0._shake_amount ~= l_6_8 then
			l_6_0._asm:set_global("shake_amount", l_6_8)
			l_6_0._shake_amount = l_6_8
		end
		l_6_0._fov = l_6_7:value()
		local l_6_9 = l_6_0._damage_data
		local l_6_10 = l_6_0._camera_data
		if l_6_6.strangul then
			l_6_0:strangul()
		elseif l_6_10.enter_dead then
			l_6_0:enter_dead()
		elseif l_6_10.dead then
			l_6_0:dead()
		elseif l_6_6.rail_vehicle_shake then
			l_6_0:on_vehicle(l_6_6.rail_vehicle_shake)
		elseif l_6_6.reviving then
			l_6_0:reviving()
		elseif l_6_6.running then
			l_6_0:running(0, false)
		elseif l_6_6.walking then
			l_6_0:walking(0, false)
		else
			l_6_0:idle(false)
		end
		local l_6_11 = l_6_0._object
		l_6_0._local_position = l_6_11:local_position()
		l_6_0._local_rotation = l_6_11:local_rotation()
	end
	SharedCamera.update(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	l_6_5:set_position(l_6_0._position)
	l_6_0.entering_dead_done = l_6_0._unit_data.entering_dead_done
end

DocumentaryCamera._set_shake_amount = function(l_7_0, l_7_1)
	l_7_0._target_shake_amount:set_target(l_7_1)
end

DocumentaryCamera.idle = function(l_8_0, l_8_1)
	if l_8_1 then
		l_8_0._anim_unit:play_redirect("aim")
	else
		l_8_0._anim_unit:play_redirect("idle")
	end
	l_8_0:_set_shake_amount(0)
end

DocumentaryCamera.walking = function(l_9_0, l_9_1, l_9_2)
	if l_9_2 then
		l_9_0._anim_unit:play_redirect("aim")
	else
		local l_9_3 = DocumentaryCamera.walk_dir_redirects[l_9_0._player_data.move_dir]
	if l_9_3 then
		end
		l_9_0._anim_unit:play_redirect(l_9_3)
	end
	if l_9_0._player_data.is_precision_aiming then
		l_9_0:_set_shake_amount(l_9_0._cam_settings.walk_aim_shake)
	else
		l_9_0:_set_shake_amount(l_9_0._cam_settings.walk_shake)
	end
end

DocumentaryCamera.running = function(l_10_0, l_10_1, l_10_2)
	if l_10_2 then
		l_10_0._anim_unit:play_redirect("aim")
	else
		local l_10_3 = DocumentaryCamera.run_dir_redirects[l_10_0._player_data.move_dir]
	if l_10_3 then
		end
		l_10_0._anim_unit:play_redirect(l_10_3)
	end
	l_10_0:_set_shake_amount(l_10_0._cam_settings.run_shake)
end

DocumentaryCamera.reviving = function(l_11_0)
	l_11_0._anim_unit:play_redirect("revive")
end

DocumentaryCamera.wounded = function(l_12_0)
	l_12_0._anim_unit:play_redirect("wounded")
end

DocumentaryCamera.enter_dead = function(l_13_0)
	l_13_0._anim_unit:play_redirect("enter_dead")
end

DocumentaryCamera.dead = function(l_14_0)
	l_14_0._anim_unit:play_redirect("dead")
end

DocumentaryCamera.strangul = function(l_15_0)
	l_15_0._anim_unit:play_redirect("strangul")
end

DocumentaryCamera.on_vehicle = function(l_16_0, l_16_1)
	l_16_0._anim_unit:play_redirect(l_16_1)
end

DocumentaryCamera.debug_render = function(l_17_0, l_17_1, l_17_2)
	SharedCamera.debug_render(l_17_0, l_17_1, l_17_2)
	local l_17_3 = Draw:brush(Color(0.5, 1, 0, 0))
	l_17_3:sphere(l_17_0:position(), 10)
end


