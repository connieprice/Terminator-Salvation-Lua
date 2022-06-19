require("shared/camera/SharedCamera")
require("shared/Interpolator")
local l_0_0 = mvector3.set
if not EnvironmentCamera then
	EnvironmentCamera = class(SharedCamera)
end
EnvironmentCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._target_fov = Interpolator:new(0, 4)
	l_1_0._target_shake_amount = Interpolator:new(0, 4)
	l_1_0._disable_avoid = false
	l_1_0._listener_id = nil
	l_1_0._explosion_anim = "explosion"
	l_1_0._amplitude = 0
	l_1_0._frequency = 0
end

EnvironmentCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.unit then
		l_2_0._anim_unit_name = l_2_1.unit
	end
	if l_2_1.object then
		l_2_0._object_name = l_2_1.object
	end
	if l_2_1.detail_unit then
		l_2_0._anim_detail_unit_name = l_2_1.detail_unit
	end
	if l_2_1.detail_object then
		l_2_0._detail_object_name = l_2_1.detail_object
	end
	if l_2_1.disable_avoid then
		l_2_0._disable_avoid = true
	end
	if l_2_1.explosion_anim then
		l_2_0._explosion_anim = l_2_1.explosion_anim
	end
end

EnvironmentCamera.preload_units = function(l_3_0)
	local l_3_1 = l_3_0.unit
	if l_3_1 then
		World:preload_unit(l_3_1)
	end
	local l_3_2 = l_3_0.detail_unit
	if l_3_2 then
		World:preload_unit(l_3_2)
	end
end

EnvironmentCamera.destroy = function(l_4_0)
	SharedCamera.destroy(l_4_0)
	if alive(l_4_0._anim_unit) then
		l_4_0._anim_unit:set_slot(0)
		l_4_0._anim_unit = nil
		l_4_0._object = nil
	end
	if alive(l_4_0._anim_detail_unit) then
		l_4_0._anim_detail_unit:set_slot(0)
		l_4_0._anim_detail_unit = nil
		l_4_0._detail_object = nil
	end
	if l_4_0._action_event_registered then
		managers.action_event:unregister_listener(l_4_0)
		managers.camera:destroy_listener(l_4_0._listener_id)
	end
end

EnvironmentCamera.on_activate = function(l_5_0, l_5_1)
	if l_5_1 then
		assert(not l_5_0._action_event_registered)
		managers.action_event:register_listener(l_5_0, l_5_0._anim_unit, l_5_0._root_unit)
		l_5_0._listener_id = managers.camera:create_listener()
		do
			local l_5_2 = assert
			l_5_2(l_5_0._anim_unit == nil)
			l_5_2 = World
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_0._anim_unit = l_5_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_2(l_5_2, "script")
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_2(l_5_2, false)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_5_2 then
				l_5_0._object = l_5_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				l_5_0._object = l_5_2
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_0._asm = l_5_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_0._anim_detail_unit = l_5_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_2(l_5_2, "script")
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_2(l_5_2, false)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_5_2 then
				l_5_0._detail_object = l_5_2
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				l_5_0._detail_object = l_5_2
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_5_0._detail_asm = l_5_2
			l_5_0._amplitude = 0
			l_5_0._frequency = 0
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_5_2(l_5_0._action_event_registered)
		managers.action_event:unregister_listener(l_5_0)
		managers.camera:destroy_listener(l_5_0._listener_id)
		l_5_0._anim_unit:set_slot(0)
		l_5_0._anim_unit = nil
		l_5_0._object = nil
		l_5_0._asm = nil
		l_5_0._anim_detail_unit:set_slot(0)
		l_5_0._anim_detail_unit = nil
		l_5_0._detail_object = nil
		l_5_0._detail_asm = nil
	end
	l_5_0._action_event_registered = l_5_1
end

EnvironmentCamera.update = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	-- upvalues: l_0_0
	local l_6_5 = l_6_0._anim_unit
	local l_6_6 = l_6_0._anim_detail_unit
	assert(l_6_0._anim_unit)
	local l_6_7 = l_6_0._object
	local l_6_8 = l_6_0._detail_object
	l_0_0(l_6_0._local_position, l_6_7:local_position() + l_6_8:local_position():rotate_with(l_6_7:local_rotation()))
	l_6_0._local_rotation = l_6_7:local_rotation()
	SharedCamera.update(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	l_6_5:set_position(l_6_0._root_unit:position())
	l_6_6:set_position(l_6_0._root_unit:position())
	local l_6_9 = managers.camera
	local l_6_10 = l_6_0._listener_id
	l_6_9:set_listener_position(l_6_10, l_6_0._position)
	l_6_9:set_listener_rotation(l_6_10, l_6_0._rotation)
	local l_6_11 = l_6_9:listener_data(l_6_10)
	local l_6_12 = l_6_0._asm
	if l_6_0._amplitude ~= l_6_11.amplitude then
		l_6_12:set_global("g_ground_shake_amplitude", l_6_11.amplitude)
		l_6_0._amplitude = l_6_11.amplitude
	end
	if l_6_0._frequency ~= l_6_11.frequency then
		l_6_12:set_global("g_ground_shake_frequency", l_6_11.frequency)
		l_6_0._frequency = l_6_11.frequency
	end
end

EnvironmentCamera.unit_explode = function(l_7_0, l_7_1, l_7_2, l_7_3)
	l_7_0:unit_explosion(l_7_1, l_7_2)
end

EnvironmentCamera.unit_explosion = function(l_8_0, l_8_1, l_8_2)
	managers.environment:create_blur("explosion_medium", l_8_0._anim_unit:position())
	local l_8_3 = l_8_0._root_unit:position()
	local l_8_4 = l_8_2 - l_8_3:length()
	local l_8_5 = 1 - math.clamp(l_8_4, 0, 1500) / 1500
	local l_8_6 = math.random()
	local l_8_7 = math.random()
	local l_8_8 = l_8_0._detail_asm
	l_8_8:set_global("g_scale", l_8_5)
	l_8_8:set_global("g_u", l_8_6)
	l_8_8:set_global("g_v", l_8_7)
	l_8_0._anim_detail_unit:play_redirect(l_8_0._explosion_anim)
end

EnvironmentCamera.unit_afro_hit = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5)
	if not l_9_0._disable_avoid then
		l_9_0._anim_detail_unit:play_redirect("avoid_bullet")
	end
	managers.environment:create_blur("whizbyblur", l_9_4)
end

EnvironmentCamera.unit_player_damage = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6)
	l_10_0._anim_detail_unit:play_redirect("hit")
end

EnvironmentCamera._calculate_amount = function(l_11_0, l_11_1, l_11_2)
	if 100 - l_11_1 - l_11_2:length() < 0 then
		return 0
	end
end

EnvironmentCamera.unit_spawn_projectile = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
	if l_12_2 == "InstantBullet" then
		local l_12_5 = l_12_0:_calculate_amount(l_12_3, l_12_0._anim_unit:position()) * 0.1
	end
	l_12_0:_trigger_radial_blur(l_12_3, l_12_2)
end

EnvironmentCamera._trigger_radial_blur = function(l_13_0, l_13_1, l_13_2)
	if not l_13_0:is_active() then
		return 
	end
	local l_13_3 = nil
	if l_13_2 == "InstantBullet" then
		l_13_3 = "spawn_instant_bullet"
	else
		l_13_3 = "spawn_projectile"
	end
	managers.environment:create_blur(l_13_3, l_13_1)
end

EnvironmentCamera.unit_weapon_shake_start = function(l_14_0, l_14_1, l_14_2, l_14_3)
	l_14_0._anim_unit:play_redirect(l_14_3)
end

EnvironmentCamera.unit_weapon_shake_stop = function(l_15_0, l_15_1)
	l_15_0._anim_unit:play_redirect("stop_shake")
end

EnvironmentCamera.debug_render = function(l_16_0, l_16_1, l_16_2)
	SharedCamera.debug_render(l_16_0, l_16_1, l_16_2)
	local l_16_3 = Draw:brush(Color(0.5, 0, 0, 1))
	l_16_3:sphere(l_16_0:position(), 3)
end


