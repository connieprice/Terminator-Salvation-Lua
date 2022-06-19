require("utils/SimpleRandomGenerator")
if not FireLogic then
	FireLogic = class()
end
FireLogic.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._fire_time = 0
	l_1_0._firing = false
	l_1_0._enabled = false
	l_1_0._fire_trigger_hold = false
	l_1_0._last_fire_input = 0
	l_1_0._sustained_burst = false
	l_1_0._pause_update = false
	l_1_0._wdata = l_1_0._unit:weapon_data()
	if l_1_0._random_burst_variation then
		l_1_0._random_generator = SimpleRandomGenerator:new(l_1_0._random_burst_variation)
	end
	l_1_0._init_logic = true
	if l_1_0._clip_size < 0 then
		l_1_0._wdata._clip_size = math.huge
	else
		l_1_0._wdata._clip_size = l_1_0._clip_size
	end
	if l_1_0._bullets_in_clip < 0 then
		l_1_0._wdata._bullets_in_clip = math.huge
	else
		l_1_0._wdata._bullets_in_clip = l_1_0._bullets_in_clip
	end
	if l_1_0._ammo_pool < 0 then
		l_1_0._wdata._ammo_pool = math.huge
	else
		l_1_0._wdata._ammo_pool = l_1_0._ammo_pool
	end
	if l_1_0._max_ammo < 0 then
		l_1_0._wdata._max_ammo = math.huge
	else
		l_1_0._wdata._max_ammo = l_1_0._max_ammo
	end
	if l_1_0._disable_update_scheduling then
		local l_1_2 = {}
		l_1_2.update = function(l_2_0, ...)
			-- upvalues: l_1_0
			l_1_0._update(...)
    end
		l_1_0._updater = l_1_2
	else
		local l_1_3 = "fire_logic"
		l_1_0._updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0._update, l_1_3))
	end
	l_1_0._extension_enabled = true
end

FireLogic.unit = function(l_2_0)
	return l_2_0._unit
end

FireLogic.on_extension_update_enabled = function(l_3_0, l_3_1)
	l_3_0._update_enabled = l_3_1
	if l_3_1 then
		l_3_0._unit:set_extension_update_enabled("logic", true)
		l_3_0._extension_enabled = true
	end
end

FireLogic.destroy = function(l_4_0)
	if not l_4_0._disable_update_scheduling then
		l_4_0._updater:remove()
	end
end

FireLogic.update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0._updater:update(l_5_0, l_5_3, l_5_1, l_5_2)
	if l_5_0._extension_enabled and not l_5_0._update_enabled and not l_5_0._firing then
		l_5_0._extension_enabled = false
		l_5_0._unit:set_extension_update_enabled("logic", false)
	end
end

FireLogic._update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = l_6_0._wdata
	if not l_6_0._pause_update or l_6_4.fire_input == 0 then
		local l_6_5 = l_6_0._fire_delay
	end
	local l_6_6 = l_6_0._burst_delay
	if l_6_0._init_logic then
		if l_6_0._clip_size < 0 then
			l_6_0._clip_size = math.huge
		end
		if l_6_0._bullets_in_clip < 0 then
			l_6_0._bullets_in_clip = math.huge
		end
		if l_6_0._ammo_pool < 0 then
			l_6_0._ammo_pool = math.huge
		end
		if l_6_0._max_ammo < 0 then
			l_6_0._max_ammo = math.huge
		end
		if l_6_0._bullets_in_burst < 0 then
			l_6_0._bullets_in_burst = math.huge
		end
		l_6_4.fire_trigger_threshold = tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD
		l_6_4.fire_trigger_release_threshold = tweak_data.player.weapon.FIRE_TRIGGER_RELEASE_THRESHOLD
		l_6_4.forced_semi_automatic_fire = not l_6_0._fully_automatic
		l_6_4._clip_size = l_6_0._clip_size
		l_6_4._ammo_pool = l_6_0._ammo_pool
		l_6_4._max_ammo = l_6_0._max_ammo
		l_6_0:_reset_burst_count()
		l_6_0._init_logic = false
	end
	local l_6_7 = assert
	l_6_7(l_6_0._ammo_pool <= l_6_0._max_ammo)
	l_6_7 = assert
	l_6_7(l_6_0._bullets_in_clip >= 0 and l_6_0._bullets_in_clip <= l_6_0._clip_size)
	l_6_7 = l_6_0._last_fire_input
	if l_6_7 < l_6_4.fire_trigger_threshold then
		l_6_7 = l_6_4.fire_input
	if l_6_4.fire_trigger_threshold > l_6_7 then
		end
	end
	l_6_7 = false
	do
		local l_6_17, l_6_19 = , ((not l_6_0._fire_trigger_hold or l_6_4.fire_trigger_release_threshold <= l_6_0._last_fire_input and l_6_4.fire_input < l_6_4.fire_trigger_release_threshold) and not l_6_7)
	end
	l_6_0._last_fire_input = l_6_4.fire_input
	 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_6_19 or not l_6_0._fully_automatic or l_6_4._fire_enabled then
		if l_6_4._reload_request then
			l_6_0:reload(true)
			 -- DECOMPILER ERROR: Confused about usage of registers!

		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if ((not l_6_0._firing and not l_6_4.forced_semi_automatic_fire and l_6_0._fire_time + l_6_6 < l_6_3 and true) or l_6_0._firing) and l_6_0._bullets_in_clip == 0 and l_6_0._auto_reload then
			l_6_0:reload(false)
		end
		do return end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if true and not l_6_0._firing and l_6_0._fire_time + l_6_5 < l_6_3 then
			l_6_0:fire_start(l_6_3)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_6_0:fire(l_6_3)
		end
		do return end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_6_0._firing and l_6_0._fire_time + l_6_5 < l_6_3 then
			l_6_0:fire(l_6_3)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_6_0._firing and (l_6_0._bullets_in_clip == 0 or ((not l_6_4.forced_semi_automatic_fire and l_6_0._bullets_in_burst > 0 and l_6_0._burst_count == 0) or not not l_6_4.forced_semi_automatic_fire and (not l_6_0._sustained_burst or l_6_0._burst_count == 0))) then
			l_6_0:fire_end(l_6_3)
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_6_0._firing then
		l_6_0:fire_end(l_6_3)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_4._bullets_in_clip = l_6_0._bullets_in_clip
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_4._ammo_pool = l_6_0._ammo_pool
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_4._reload_ready = l_6_0._ammo_pool > 0 and l_6_0._fire_time + l_6_5 < l_6_3
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_4._reload_required = l_6_0._ammo_pool > 0 and l_6_0._bullets_in_clip == 0
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_4._firing = l_6_0._firing
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0._fire_trigger_hold = not l_6_4.forced_semi_automatic_fire
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0._pause_update = not l_6_0._firing and l_6_0._fire_time + l_6_5 < l_6_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

FireLogic.fire_start = function(l_7_0, l_7_1)
	local l_7_2 = assert
	l_7_2(l_7_0._firing == false)
	l_7_0._firing = true
	l_7_2 = l_7_0._wdata
	l_7_2._fire_start = true
	l_7_2 = l_7_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_7_2.fire_start then
		l_7_2:fire_start(l_7_1)
	end
end

FireLogic._reset_burst_count = function(l_8_0)
	if l_8_0._random_burst_variation and l_8_0._bullets_in_burst then
		l_8_0._burst_count = l_8_0._bullets_in_burst - l_8_0._random_burst_variation + l_8_0._random_generator:rand() % (2 * l_8_0._random_burst_variation)
		local l_8_1 = assert
		l_8_1(l_8_0._burst_count > 0)
	else
		l_8_0._burst_count = l_8_0._bullets_in_burst
	end
end

FireLogic.fire_end = function(l_9_0, l_9_1)
	l_9_0._firing = false
	l_9_0:_reset_burst_count()
	l_9_0._wdata._fire_end = true
	local l_9_2 = l_9_0._unit:base()
	if l_9_2.fire_end then
		l_9_2:fire_end(l_9_1)
	end
end

FireLogic.fire = function(l_10_0, l_10_1)
	local l_10_2 = assert
	l_10_2(l_10_0._bullets_in_clip > 0)
	l_10_0._fire_time = l_10_1
	l_10_2 = l_10_0._bullets_in_clip
	l_10_2 = l_10_2 - 1
	l_10_0._bullets_in_clip = l_10_2
	l_10_2 = math
	l_10_2 = l_10_2.max
	l_10_2 = l_10_2(l_10_0._burst_count - 1, 0)
	l_10_0._burst_count = l_10_2
	l_10_2 = l_10_0._wdata
	l_10_2._on_fire = true
	l_10_2 = l_10_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_10_2.fire then
		l_10_2:fire(l_10_1)
	end
end

FireLogic.reload = function(l_11_0, l_11_1)
	if l_11_0._ammo_pool > 0 then
		if (l_11_0._ammo_pool >= l_11_0._clip_size - l_11_0._bullets_in_clip or l_11_1) and l_11_0._reload_refill and l_11_0._reload_refill < l_11_0._ammo_pool then
			local l_11_2 = l_11_0._reload_refill
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_11_0._bullets_in_clip = l_11_0._bullets_in_clip + l_11_2
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not script_debug or not script_debug.infinite_ammo or not 0 then
			l_11_0._ammo_pool = l_11_0._ammo_pool - l_11_2
			local l_11_5 = nil
			assert(l_11_0._bullets_in_clip >= 0)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 33 
end

FireLogic.set_ammo = function(l_12_0, l_12_1)
	do
		local l_12_2 = assert
		l_12_2(l_12_1 >= 0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_12_2 >= 0 or not math.huge then
			l_12_1 = math.clamp(l_12_1, 0, l_12_2)
			l_12_0._ammo_pool = l_12_1
			l_12_0._bullets_in_clip = 0
			l_12_0:reload(false)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

FireLogic.fill_ammo = function(l_13_0, l_13_1)
	local l_13_2 = l_13_0._max_ammo - l_13_0:bullet_count()
	local l_13_3 = math.max(0, math.min(l_13_1, l_13_2))
	l_13_0._ammo_pool = l_13_0._ammo_pool + l_13_3
	local l_13_4 = assert
	l_13_4(l_13_0._ammo_pool >= 0)
	l_13_4 = assert
	l_13_4(l_13_0._ammo_pool <= l_13_0._max_ammo)
	return l_13_3
end

FireLogic.clip_size = function(l_14_0)
	return l_14_0._clip_size
end

FireLogic.ammo_pool = function(l_15_0)
	return l_15_0._ammo_pool
end

FireLogic.bullet_count = function(l_16_0)
	return l_16_0._bullets_in_clip + l_16_0._ammo_pool
end

FireLogic.bullet_space_left = function(l_17_0)
	return l_17_0._max_ammo - l_17_0:bullet_count()
end

FireLogic.remove_bullets = function(l_18_0, l_18_1)
	l_18_1 = math.max(0, math.min(l_18_1, l_18_0:bullet_count()))
	local l_18_2 = math.min(l_18_1, l_18_0._ammo_pool)
	l_18_0._ammo_pool = l_18_0._ammo_pool - l_18_2
	local l_18_3 = assert
	l_18_3(l_18_0._ammo_pool >= 0)
	l_18_1 = l_18_1 - l_18_2
	l_18_3 = l_18_0._bullets_in_clip
	l_18_3 = l_18_3 - (l_18_1)
	l_18_0._bullets_in_clip = l_18_3
	l_18_3 = assert
	l_18_3(l_18_0._bullets_in_clip >= 0)
end

FireLogic.has_overheat = function(l_19_0)
	return not l_19_0._overheat_threshold or l_19_0._overheat_threshold > 0
end

FireLogic.show_overheat_hud = function(l_20_0)
	return l_20_0._overheat_hud
end

FireLogic.max_ammo = function(l_21_0)
	return l_21_0._max_ammo
end

if not FireLogicOverheat then
	FireLogicOverheat = class(FireLogic)
end
FireLogicOverheat.init = function(l_22_0, l_22_1)
	FireLogic.init(l_22_0, l_22_1)
	l_22_0._heat = 0
	l_22_0._cooldown_time = 0
	l_22_0._is_overheated = false
	l_22_0._anim_played = false
	l_22_0._cooldown_delay = 0
	l_22_0._heat_end_time = 0
	l_22_0._overheat_cooldown_delay = l_22_0._overheat_cooldown_delay or 1
	l_22_0._cooldown_to_firing_delay = l_22_0._overheat_cooldown_delay
	l_22_0._overheated_to_cooldown_delay = l_22_0._overheat_cooldown_delay or 1
end

FireLogicOverheat.fire = function(l_23_0, l_23_1)
	FireLogic.fire(l_23_0, l_23_1)
	l_23_0._heat_end_time = l_23_1 + l_23_0._fire_delay
end

FireLogicOverheat._update_overheat_status = function(l_24_0, l_24_1, l_24_2)
	if not l_24_0._is_overheated then
		if l_24_1 < l_24_0._heat_end_time then
			l_24_0._heat = l_24_0._heat + l_24_2
		end
	elseif l_24_0._heat >= 0 and l_24_0._fire_time + l_24_0._cooldown_delay < l_24_1 then
		if l_24_0._cooldown then
			l_24_0._heat = l_24_0._heat - l_24_2 * (l_24_0._overheat_threshold / l_24_0._cooldown)
		end
	else
		l_24_0._heat = l_24_0._heat - l_24_2
	end
	if l_24_0._is_overheated then
		if l_24_0._overheated_to_cooldown_delay > 0 then
			l_24_0._overheated_to_cooldown_delay = l_24_0._overheated_to_cooldown_delay - l_24_2
		end
	else
		l_24_0._cooldown_time = l_24_0._cooldown_time - l_24_2
		if l_24_0._overheat_anim and l_24_0._cooldown_time < l_24_0._coldown_until_anim and not l_24_0._anim_played then
			l_24_0._wdata._overheat_anim = l_24_0._overheat_anim
			l_24_0._anim_played = true
		end
	if l_24_0._cooldown_time <= 0 then
		end
		if l_24_0._cooldown_to_firing_delay > 0 then
			l_24_0._cooldown_to_firing_delay = l_24_0._cooldown_to_firing_delay - l_24_2
		end
	else
		l_24_0._anim_played = false
		l_24_0._is_overheated = false
		l_24_0._overheated_to_cooldown_delay = l_24_0._overheat_cooldown_delay
		l_24_0._cooldown_to_firing_delay = l_24_0._overheat_cooldown_delay
	if l_24_0._run_overheat_sequence then
		end
		managers.sequence:run_sequence_simple("overheat_off", l_24_0._unit)
	end
	if l_24_0._overheat_threshold <= l_24_0._heat then
		l_24_0._cooldown_time = l_24_0._overheat_cooldown
		l_24_0._is_overheated = true
		l_24_0._heat = 0
		if l_24_0._firing then
			l_24_0:fire_end(l_24_1)
		end
		if l_24_0._overheat_effect then
			local l_24_3, l_24_4 = World:effect_manager():spawn, World:effect_manager()
			local l_24_5 = {}
			l_24_5.effect = l_24_0._overheat_effect
			l_24_5.parent = l_24_0._unit:get_object("fire")
			l_24_3(l_24_4, l_24_5)
		end
	if l_24_0._run_overheat_sequence then
		end
		managers.sequence:run_sequence_simple("overheat_on", l_24_0._unit)
	end
end

FireLogicOverheat.update = function(l_25_0, l_25_1, l_25_2, l_25_3)
	if not l_25_0._is_overheated then
		FireLogic.update(l_25_0, l_25_1, l_25_2, l_25_3)
	end
	l_25_0:_update_overheat_status(l_25_2, l_25_3)
end

FireLogicOverheat.get_overheat_percent = function(l_26_0)
	local l_26_1 = nil
	if not l_26_0._is_overheated then
		l_26_1 = l_26_0._heat / l_26_0._overheat_threshold
	else
		l_26_1 = l_26_0._cooldown_time / l_26_0._overheat_cooldown
	end
	if l_26_1 < 0 then
		l_26_1 = 0
	end
	return l_26_1
end

FireLogicOverheat.is_overheated = function(l_27_0)
	return l_27_0._is_overheated
end

FireLogicOverheat.destroy = function(l_28_0)
end


