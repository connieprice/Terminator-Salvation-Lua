require("utils/SimpleRandomGenerator")
FireLogic = FireLogic or class()
function FireLogic.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	A0_0._fire_time = 0
	A0_0._firing = false
	A0_0._enabled = false
	A0_0._fire_trigger_hold = false
	A0_0._last_fire_input = 0
	A0_0._sustained_burst = false
	A0_0._pause_update = false
	L2_2 = A0_0._unit
	L2_2 = L2_2.weapon_data
	L2_2 = L2_2(L2_2)
	A0_0._wdata = L2_2
	L2_2 = A0_0._random_burst_variation
	if L2_2 then
		L2_2 = SimpleRandomGenerator
		L2_2 = L2_2.new
		L2_2 = L2_2(L2_2, A0_0._random_burst_variation)
		A0_0._random_generator = L2_2
	end
	A0_0._init_logic = true
	L2_2 = A0_0._clip_size
	if L2_2 < 0 then
		L2_2 = A0_0._wdata
		L2_2._clip_size = math.huge
	else
		L2_2 = A0_0._wdata
		L2_2._clip_size = A0_0._clip_size
	end
	L2_2 = A0_0._bullets_in_clip
	if L2_2 < 0 then
		L2_2 = A0_0._wdata
		L2_2._bullets_in_clip = math.huge
	else
		L2_2 = A0_0._wdata
		L2_2._bullets_in_clip = A0_0._bullets_in_clip
	end
	L2_2 = A0_0._ammo_pool
	if L2_2 < 0 then
		L2_2 = A0_0._wdata
		L2_2._ammo_pool = math.huge
	else
		L2_2 = A0_0._wdata
		L2_2._ammo_pool = A0_0._ammo_pool
	end
	L2_2 = A0_0._max_ammo
	if L2_2 < 0 then
		L2_2 = A0_0._wdata
		L2_2._max_ammo = math.huge
	else
		L2_2 = A0_0._wdata
		L2_2._max_ammo = A0_0._max_ammo
	end
	L2_2 = A0_0._disable_update_scheduling
	if L2_2 then
		L2_2 = {}
		function L2_2.update(A0_3, ...)
			local L3_5
			L3_5 = _UPVALUE0_
			L3_5 = L3_5._update
			L3_5(...)
		end
		A0_0._updater = L2_2
	else
		L2_2 = "fire_logic"
		A0_0._updater = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_0._update, L2_2))
	end
	A0_0._extension_enabled = true
end
function FireLogic.unit(A0_6)
	local L1_7
	L1_7 = A0_6._unit
	return L1_7
end
function FireLogic.on_extension_update_enabled(A0_8, A1_9)
	A0_8._update_enabled = A1_9
	if A1_9 then
		A0_8._unit:set_extension_update_enabled("logic", true)
		A0_8._extension_enabled = true
	end
end
function FireLogic.destroy(A0_10)
	if not A0_10._disable_update_scheduling then
		A0_10._updater:remove()
	end
end
function FireLogic.update(A0_11, A1_12, A2_13, A3_14)
	A0_11._updater:update(A0_11, A3_14, A1_12, A2_13)
	if A0_11._extension_enabled and not A0_11._update_enabled and not A0_11._firing then
		A0_11._extension_enabled = false
		A0_11._unit:set_extension_update_enabled("logic", false)
	end
end
function FireLogic._update(A0_15, A1_16, A2_17, A3_18)
	local L4_19, L5_20
	L4_19 = A0_15._wdata
	L5_20 = A0_15._pause_update
	if L5_20 then
		L5_20 = L4_19.fire_input
		if L5_20 == 0 then
		end
	end
	L5_20 = A0_15._fire_delay
	if A0_15._init_logic then
		if 0 > A0_15._clip_size then
			A0_15._clip_size = math.huge
		end
		if 0 > A0_15._bullets_in_clip then
			A0_15._bullets_in_clip = math.huge
		end
		if 0 > A0_15._ammo_pool then
			A0_15._ammo_pool = math.huge
		end
		if 0 > A0_15._max_ammo then
			A0_15._max_ammo = math.huge
		end
		if 0 > A0_15._bullets_in_burst then
			A0_15._bullets_in_burst = math.huge
		end
		L4_19.fire_trigger_threshold = tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD
		L4_19.fire_trigger_release_threshold = tweak_data.player.weapon.FIRE_TRIGGER_RELEASE_THRESHOLD
		L4_19.forced_semi_automatic_fire = not A0_15._fully_automatic
		L4_19._clip_size = A0_15._clip_size
		L4_19._ammo_pool = A0_15._ammo_pool
		L4_19._max_ammo = A0_15._max_ammo
		A0_15:_reset_burst_count()
		A0_15._init_logic = false
	end
	assert(A0_15._ammo_pool <= A0_15._max_ammo)
	assert(0 <= A0_15._bullets_in_clip and A0_15._bullets_in_clip <= A0_15._clip_size)
	A0_15._last_fire_input = L4_19.fire_input
	L4_19._fire_start = false
	L4_19._fire_end = false
	L4_19._on_fire = false
	if L4_19._fire_enabled then
		if L4_19._reload_request then
			A0_15:reload(true)
			L4_19._reload_request = false
		end
		if true or A0_15._firing then
			if A0_15._bullets_in_clip == 0 then
				if A0_15._auto_reload then
					A0_15:reload(false)
				end
			elseif true and not A0_15._firing then
				if A3_18 > A0_15._fire_time + L5_20 then
					A0_15:fire_start(A3_18)
					A0_15:fire(A3_18)
				end
			elseif A0_15._firing and A3_18 > A0_15._fire_time + L5_20 then
				A0_15:fire(A3_18)
			end
		end
		if A0_15._firing and (A0_15._bullets_in_clip == 0 or (A0_15._fire_trigger_hold and not (A0_15._last_fire_input >= L4_19.fire_trigger_release_threshold and L4_19.fire_input < L4_19.fire_trigger_release_threshold) or A0_15._last_fire_input < L4_19.fire_trigger_threshold and L4_19.fire_input >= L4_19.fire_trigger_threshold and not A0_15._fire_trigger_hold) and A0_15._fully_automatic and not L4_19.forced_semi_automatic_fire and 0 < A0_15._bullets_in_burst and A0_15._burst_count == 0 or not ((A0_15._fire_trigger_hold and not (A0_15._last_fire_input >= L4_19.fire_trigger_release_threshold and L4_19.fire_input < L4_19.fire_trigger_release_threshold) or A0_15._last_fire_input < L4_19.fire_trigger_threshold and L4_19.fire_input >= L4_19.fire_trigger_threshold and not A0_15._fire_trigger_hold) and A0_15._fully_automatic and not L4_19.forced_semi_automatic_fire) and (not A0_15._sustained_burst or A0_15._burst_count == 0)) then
			A0_15:fire_end(A3_18)
		end
	elseif A0_15._firing then
		A0_15:fire_end(A3_18)
	end
	L4_19._bullets_in_clip = A0_15._bullets_in_clip
	L4_19._ammo_pool = A0_15._ammo_pool
	L4_19._reload_ready = 0 < A0_15._ammo_pool and A3_18 > A0_15._fire_time + L5_20
	L4_19._reload_required = 0 < A0_15._ammo_pool and A0_15._bullets_in_clip == 0
	A0_15._fire_trigger_hold, L4_19._firing = (A0_15._fire_trigger_hold and not (A0_15._last_fire_input >= L4_19.fire_trigger_release_threshold and L4_19.fire_input < L4_19.fire_trigger_release_threshold) or A0_15._last_fire_input < L4_19.fire_trigger_threshold and L4_19.fire_input >= L4_19.fire_trigger_threshold and not A0_15._fire_trigger_hold) and A0_15._fully_automatic and not L4_19.forced_semi_automatic_fire, A0_15._firing
	A0_15._pause_update = not A0_15._firing and A3_18 > A0_15._fire_time + L5_20
end
function FireLogic.fire_start(A0_21, A1_22)
	assert(A0_21._firing == false)
	A0_21._firing = true
	A0_21._wdata._fire_start = true
	if A0_21._unit:base().fire_start then
		A0_21._unit:base():fire_start(A1_22)
	end
end
function FireLogic._reset_burst_count(A0_23)
	if A0_23._random_burst_variation and A0_23._bullets_in_burst then
		A0_23._burst_count = A0_23._bullets_in_burst - A0_23._random_burst_variation + A0_23._random_generator:rand() % (2 * A0_23._random_burst_variation)
		assert(A0_23._burst_count > 0)
	else
		A0_23._burst_count = A0_23._bullets_in_burst
	end
end
function FireLogic.fire_end(A0_24, A1_25)
	A0_24._firing = false
	A0_24:_reset_burst_count()
	A0_24._wdata._fire_end = true
	if A0_24._unit:base().fire_end then
		A0_24._unit:base():fire_end(A1_25)
	end
end
function FireLogic.fire(A0_26, A1_27)
	assert(A0_26._bullets_in_clip > 0)
	A0_26._fire_time = A1_27
	A0_26._bullets_in_clip = A0_26._bullets_in_clip - 1
	A0_26._burst_count = math.max(A0_26._burst_count - 1, 0)
	A0_26._wdata._on_fire = true
	if A0_26._unit:base().fire then
		A0_26._unit:base():fire(A1_27)
	end
end
function FireLogic.reload(A0_28, A1_29)
	local L2_30
	L2_30 = A0_28._ammo_pool
	if L2_30 > 0 then
		L2_30 = A0_28._clip_size
		L2_30 = L2_30 - A0_28._bullets_in_clip
		if L2_30 > A0_28._ammo_pool then
			L2_30 = A0_28._ammo_pool
		end
		if A1_29 and A0_28._reload_refill and L2_30 > A0_28._reload_refill then
			L2_30 = A0_28._reload_refill
		end
		A0_28._bullets_in_clip = A0_28._bullets_in_clip + L2_30
		L2_30 = script_debug and script_debug.infinite_ammo and 0 or L2_30
		A0_28._ammo_pool = A0_28._ammo_pool - L2_30
		assert(0 <= A0_28._bullets_in_clip)
	end
end
function FireLogic.set_ammo(A0_31, A1_32)
	local L2_33
	L2_33 = assert
	L2_33(A1_32 >= 0)
	L2_33 = A0_31.max_ammo
	L2_33 = L2_33(A0_31)
	if L2_33 < 0 then
		L2_33 = math.huge or L2_33
	end
	A1_32 = math.clamp(A1_32, 0, L2_33)
	A0_31._ammo_pool = A1_32
	A0_31._bullets_in_clip = 0
	A0_31:reload(false)
end
function FireLogic.fill_ammo(A0_34, A1_35)
	local L2_36
	L2_36 = A0_34._max_ammo
	L2_36 = L2_36 - A0_34:bullet_count()
	A0_34._ammo_pool = A0_34._ammo_pool + math.max(0, math.min(A1_35, L2_36))
	assert(0 <= A0_34._ammo_pool)
	assert(A0_34._ammo_pool <= A0_34._max_ammo)
	return (math.max(0, math.min(A1_35, L2_36)))
end
function FireLogic.clip_size(A0_37)
	local L1_38
	L1_38 = A0_37._clip_size
	return L1_38
end
function FireLogic.ammo_pool(A0_39)
	local L1_40
	L1_40 = A0_39._ammo_pool
	return L1_40
end
function FireLogic.bullet_count(A0_41)
	return A0_41._bullets_in_clip + A0_41._ammo_pool
end
function FireLogic.bullet_space_left(A0_42)
	return A0_42._max_ammo - A0_42:bullet_count()
end
function FireLogic.remove_bullets(A0_43, A1_44)
	A1_44 = math.max(0, math.min(A1_44, A0_43:bullet_count()))
	A0_43._ammo_pool = A0_43._ammo_pool - math.min(A1_44, A0_43._ammo_pool)
	assert(0 <= A0_43._ammo_pool)
	A1_44 = A1_44 - math.min(A1_44, A0_43._ammo_pool)
	A0_43._bullets_in_clip = A0_43._bullets_in_clip - A1_44
	assert(0 <= A0_43._bullets_in_clip)
end
function FireLogic.has_overheat(A0_45)
	local L1_46
	L1_46 = A0_45._overheat_threshold
	if L1_46 then
		L1_46 = A0_45._overheat_threshold
		L1_46 = L1_46 > 0
	end
	return L1_46
end
function FireLogic.show_overheat_hud(A0_47)
	local L1_48
	L1_48 = A0_47._overheat_hud
	return L1_48
end
function FireLogic.max_ammo(A0_49)
	local L1_50
	L1_50 = A0_49._max_ammo
	return L1_50
end
FireLogicOverheat = FireLogicOverheat or class(FireLogic)
function FireLogicOverheat.init(A0_51, A1_52)
	FireLogic.init(A0_51, A1_52)
	A0_51._heat = 0
	A0_51._cooldown_time = 0
	A0_51._is_overheated = false
	A0_51._anim_played = false
	A0_51._cooldown_delay = 0
	A0_51._heat_end_time = 0
	A0_51._overheat_cooldown_delay = A0_51._overheat_cooldown_delay or 1
	A0_51._cooldown_to_firing_delay = A0_51._overheat_cooldown_delay
	A0_51._overheated_to_cooldown_delay = A0_51._overheat_cooldown_delay or 1
end
function FireLogicOverheat.fire(A0_53, A1_54)
	FireLogic.fire(A0_53, A1_54)
	A0_53._heat_end_time = A1_54 + A0_53._fire_delay
end
function FireLogicOverheat._update_overheat_status(A0_55, A1_56, A2_57)
	if not A0_55._is_overheated then
		if A1_56 < A0_55._heat_end_time then
			A0_55._heat = A0_55._heat + A2_57
		elseif A0_55._heat >= 0 and A1_56 > A0_55._fire_time + A0_55._cooldown_delay then
			if A0_55._cooldown then
				A0_55._heat = A0_55._heat - A2_57 * (A0_55._overheat_threshold / A0_55._cooldown)
			else
				A0_55._heat = A0_55._heat - A2_57
			end
		end
	end
	if A0_55._is_overheated then
		if 0 < A0_55._overheated_to_cooldown_delay then
			A0_55._overheated_to_cooldown_delay = A0_55._overheated_to_cooldown_delay - A2_57
		else
			A0_55._cooldown_time = A0_55._cooldown_time - A2_57
			if A0_55._overheat_anim and A0_55._cooldown_time < A0_55._coldown_until_anim and not A0_55._anim_played then
				A0_55._wdata._overheat_anim = A0_55._overheat_anim
				A0_55._anim_played = true
			end
			if 0 >= A0_55._cooldown_time then
				if 0 < A0_55._cooldown_to_firing_delay then
					A0_55._cooldown_to_firing_delay = A0_55._cooldown_to_firing_delay - A2_57
				else
					A0_55._anim_played = false
					A0_55._is_overheated = false
					A0_55._overheated_to_cooldown_delay = A0_55._overheat_cooldown_delay
					A0_55._cooldown_to_firing_delay = A0_55._overheat_cooldown_delay
					if A0_55._run_overheat_sequence then
						managers.sequence:run_sequence_simple("overheat_off", A0_55._unit)
					end
				end
			end
		end
	end
	if A0_55._heat >= A0_55._overheat_threshold then
		A0_55._cooldown_time = A0_55._overheat_cooldown
		A0_55._is_overheated = true
		A0_55._heat = 0
		if A0_55._firing then
			A0_55:fire_end(A1_56)
		end
		if A0_55._overheat_effect then
			World:effect_manager():spawn({
				effect = A0_55._overheat_effect,
				parent = A0_55._unit:get_object("fire")
			})
		end
		if A0_55._run_overheat_sequence then
			managers.sequence:run_sequence_simple("overheat_on", A0_55._unit)
		end
	end
end
function FireLogicOverheat.update(A0_58, A1_59, A2_60, A3_61)
	if not A0_58._is_overheated then
		FireLogic.update(A0_58, A1_59, A2_60, A3_61)
	end
	A0_58:_update_overheat_status(A2_60, A3_61)
end
function FireLogicOverheat.get_overheat_percent(A0_62)
	local L1_63, L2_64, L3_65
	L2_64 = A0_62._is_overheated
	if not L2_64 then
		L2_64 = A0_62._heat
		L3_65 = A0_62._overheat_threshold
		L1_63 = L2_64 / L3_65
	else
		L2_64 = A0_62._cooldown_time
		L3_65 = A0_62._overheat_cooldown
		L1_63 = L2_64 / L3_65
	end
	if L1_63 < 0 then
		L1_63 = 0
	end
	return L1_63
end
function FireLogicOverheat.is_overheated(A0_66)
	local L1_67
	L1_67 = A0_66._is_overheated
	return L1_67
end
function FireLogicOverheat.destroy(A0_68)
	local L1_69
end
