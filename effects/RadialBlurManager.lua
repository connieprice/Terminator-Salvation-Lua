core:module("RadialBlurManager")
core:require_module("CoreClass")
RadialBlurManager = RadialBlurManager or CoreClass.class()
function RadialBlurManager.init(A0_0)
	A0_0._blur_types = {}
	A0_0._blur_category = {}
	A0_0._current_blurs = {}
	A0_0._current_blurs_step = {}
	A0_0._current_blur_selected = {}
	A0_0._default_blur_category = nil
	A0_0._constant_blur = {}
	A0_0._constant_blur.position = Vector3(0, 0, 0)
	A0_0._constant_blur.current_opacity = 0
	A0_0._constant_blur.current_speed = 0
	A0_0._constant_blur.falloff = 0.5
	A0_0._constant_blur.time = 0
	A0_0._enabled = true
	A0_0:flush_xml()
end
function RadialBlurManager.update(A0_1, A1_2)
end
function RadialBlurManager.update_blur(A0_3, A1_4, A2_5, A3_6)
	if A0_3._current_blurs[A2_5][A1_4].sustain + A0_3._current_blurs[A2_5][A1_4].decay == 0 then
		A0_3._current_blurs[A2_5][A1_4].current_opacity = A0_3._current_blurs[A2_5][A1_4].opacity
		A0_3._current_blurs[A2_5][A1_4].current_speed = A0_3._current_blurs[A2_5][A1_4].speed
	elseif A0_3._current_blurs[A2_5][A1_4].sustain + A0_3._current_blurs[A2_5][A1_4].decay > A0_3._current_blurs[A2_5][A1_4].timer:time() then
		A0_3._current_blurs[A2_5][A1_4].current_opacity = A0_3._current_blurs[A2_5][A1_4].opacity * ((A0_3._current_blurs[A2_5][A1_4].sustain + A0_3._current_blurs[A2_5][A1_4].decay - A0_3._current_blurs[A2_5][A1_4].timer:time()) / A0_3._current_blurs[A2_5][A1_4].decay) * (1 - math.clamp((A3_6 - A0_3._current_blurs[A2_5][A1_4].position):length() - A0_3._current_blurs[A2_5][A1_4].decline_distance_min, 0, A0_3._current_blurs[A2_5][A1_4].decline_distance_range) / A0_3._current_blurs[A2_5][A1_4].decline_distance_range)
		A0_3._current_blurs[A2_5][A1_4].current_speed = A0_3._current_blurs[A2_5][A1_4].speed * ((A0_3._current_blurs[A2_5][A1_4].sustain + A0_3._current_blurs[A2_5][A1_4].decay - A0_3._current_blurs[A2_5][A1_4].timer:time()) / A0_3._current_blurs[A2_5][A1_4].decay)
	else
		A0_3._current_blurs[A2_5][A1_4] = nil
		return
	end
	if A0_3._blur_category[A0_3._current_blurs[A2_5][A1_4].category].visible == true and (A0_3._current_blur_selected == nil or A0_3._current_blur_selected.current_opacity < A0_3._current_blurs[A2_5][A1_4].current_opacity) then
		A0_3._current_blur_selected = A0_3._current_blurs[A2_5][A1_4]
	end
end
function RadialBlurManager.render_blur(A0_7, A1_8)
	if A1_8 == nil then
		A0_7._radial_mat:set_variable("opacity", 0)
	else
		A0_7._radial_mat:set_variable("world_pos", A1_8.position)
		A0_7._radial_mat:set_variable("kernel_size", A1_8.current_speed)
		A0_7._radial_mat:set_variable("falloff_exponent", A1_8.falloff)
		A0_7._radial_mat:set_variable("opacity", A1_8.current_opacity)
	end
end
function RadialBlurManager.set_velocity_blur(A0_9, A1_10, A2_11, A3_12)
	A0_9._constant_blur.position = A2_11 + A3_12:normalized() * 1500
	A0_9._constant_blur.current_opacity = 0.6 * (math.clamp(A3_12:length() - 500, 0, 4000) / 4000)
	A0_9._constant_blur.current_speed = 16 * (math.clamp(A3_12:length() - 500, 0, 4000) / 4000)
	A0_9._constant_blur.time = A1_10 + 1
end
function RadialBlurManager.get_free_blur_slot(A0_13, A1_14)
	local L2_15, L3_16, L4_17, L5_18, L7_19, L8_20, L9_21, L10_22
	L2_15 = A0_13._blur_types
	L2_15 = L2_15[A1_14]
	L2_15 = L2_15.spawn_limit
	L3_16 = 1
	L4_17 = A0_13._current_blurs_step
	L4_17 = L4_17[A1_14]
	if L4_17 then
		L4_17 = A0_13._current_blurs_step
		L3_16 = L4_17[A1_14]
	end
	while true do
		L4_17 = A0_13._current_blurs
		L4_17 = L4_17[A1_14]
		L4_17 = L4_17[L3_16]
		if L4_17 then
			L3_16 = L3_16 + 1
			L4_17 = A0_13._blur_types
			L4_17 = L4_17[A1_14]
			L4_17 = L4_17.spawn_limit
			if L3_16 > L4_17 then
				L3_16 = 1
			end
			L2_15 = L2_15 - 1
			if L2_15 == 0 then
				L4_17 = false
				L5_18 = false
				for L10_22 = 1, L8_20.spawn_limit do
					if not L4_17 or L4_17 > A0_13._current_blurs[A1_14][L10_22].time then
						L4_17 = A0_13._current_blurs[A1_14][L10_22].time
						L5_18 = L10_22
					end
				end
				L7_19[A1_14] = L5_18
				return L5_18
			end
		end
	end
	L4_17 = A0_13._current_blurs_step
	L4_17[A1_14] = L3_16
	return L3_16
end
function RadialBlurManager.create_blur(A0_23, A1_24, A2_25, A3_26)
	if not A0_23._current_blurs[A2_25] then
		A0_23._current_blurs[A2_25] = {}
	end
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)] = {}
	if A0_23._blur_types[A2_25].sustain == 0 and A0_23._blur_types[A2_25].decay == 0 then
		A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].sustain = A0_23._blur_types[A2_25].sustain
	else
		A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].sustain = A1_24:time() + A0_23._blur_types[A2_25].sustain
	end
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)]._debug_name = A2_25
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].decay = A0_23._blur_types[A2_25].decay
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].opacity = A0_23._blur_types[A2_25].opacity
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].speed = A0_23._blur_types[A2_25].speed
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].falloff = A0_23._blur_types[A2_25].falloff
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].decline_distance_min = A0_23._blur_types[A2_25].decline_distance_min
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].decline_distance_max = A0_23._blur_types[A2_25].decline_distance_max
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].decline_distance_range = A0_23._blur_types[A2_25].decline_distance_max - A0_23._blur_types[A2_25].decline_distance_min
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].category = A0_23._blur_types[A2_25].category
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].timer = A1_24
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].time = A1_24:time()
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].position = A3_26
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].current_opacity = A0_23._blur_types[A2_25].opacity
	A0_23._current_blurs[A2_25][A0_23:get_free_blur_slot(A2_25)].current_speed = A0_23._blur_types[A2_25].speed
	return {
		name = A2_25,
		index = A0_23:get_free_blur_slot(A2_25)
	}
end
function RadialBlurManager.set_visible_all(A0_27, A1_28)
	for 