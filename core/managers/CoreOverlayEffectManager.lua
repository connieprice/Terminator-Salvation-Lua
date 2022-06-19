if not CoreOverlayEffectManager then
	CoreOverlayEffectManager = class()
end
CoreOverlayEffectManager.init = function(l_1_0)
	local l_1_1 = Overlay:newgui()
	l_1_0._vp_overlay = Application:create_scene_viewport(0, 0, 1, 1)
	l_1_0._overlay_camera = Overlay:create_camera()
	l_1_0._vp_overlay:set_camera(l_1_0._overlay_camera)
	l_1_0._ws = l_1_1:create_screen_workspace()
	l_1_0._ws:set_timer(TimerManager:main())
	l_1_0._playing_effects = {}
	l_1_0._paused = nil
	l_1_0._presets = {}
	local l_1_2, l_1_3 = l_1_0:add_preset, l_1_0
	local l_1_4 = "custom"
	local l_1_5 = {}
	l_1_5.blend_mode = "normal"
	l_1_5.sustain = 0
	l_1_5.fade_in = 0
	l_1_5.fade_out = 0
	l_1_5.color = Color(1, 0, 0, 0)
	l_1_2(l_1_3, l_1_4, l_1_5)
	l_1_2, l_1_3 = l_1_0:set_default_layer, l_1_0
	l_1_4 = 30
	l_1_2(l_1_3, l_1_4)
	l_1_2 = managers
	l_1_2 = l_1_2.viewport
	l_1_2, l_1_3 = l_1_2:add_resolution_changed_func, l_1_2
	l_1_4 = callback
	l_1_5 = l_1_0
	l_1_5, l_1_4 = .end, l_1_4(l_1_5, l_1_0, "change_resolution")
	l_1_2(l_1_3, l_1_4, l_1_5)
end

CoreOverlayEffectManager.set_visible = function(l_2_0, l_2_1)
	l_2_0._ws:panel():set_visible(l_2_1)
end

CoreOverlayEffectManager.add_preset = function(l_3_0, l_3_1, l_3_2)
	l_3_0._presets[l_3_1] = l_3_2
end

CoreOverlayEffectManager.presets = function(l_4_0)
	return l_4_0._presets
end

CoreOverlayEffectManager.set_default_layer = function(l_5_0, l_5_1)
	l_5_0._default_layer = l_5_1
end

CoreOverlayEffectManager.update = function(l_6_0, l_6_1, l_6_2)
	l_6_0._vp_overlay:update()
	l_6_0:check_pause_state()
	l_6_0:progress_effects(l_6_1, l_6_2)
end

CoreOverlayEffectManager.destroy = function(l_7_0)
	if CoreCode.alive(l_7_0._overlay_camera) then
		Overlay:delete_camera(l_7_0._overlay_camera)
		l_7_0._overlay_camera = nil
	end
	if l_7_0._vp_overlay then
		Application:destroy_viewport(l_7_0._vp_overlay)
		l_7_0._vp_overlay = nil
	end
	if CoreCode.alive(l_7_0._ws) then
		Overlay:newgui():destroy_workspace(l_7_0._ws)
		l_7_0._ws = nil
	end
end

CoreOverlayEffectManager.render = function(l_8_0)
	if script_debug.render_overlay then
		Application:render("Overlay", l_8_0._vp_overlay)
	end
end

CoreOverlayEffectManager.progress_effects = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_7, l_9_8, l_9_9, l_9_10 = nil
	for i_0,i_1 in pairs(l_9_0._playing_effects) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if (not i_1.data.timer or not i_1.data.timer:time()) and (not l_9_3 or not TimerManager:game():time()) then
			local l_9_13 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1.data.sustain then
				local l_9_14 = nil
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_9_12.start_t + i_1.data.fade_in + i_1.data.sustain then
				local l_9_16 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_9_3 and not i_1.data.play_paused or l_9_1 < l_9_12.start_t + i_1.data.fade_in then
					do return end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if not l_9_12.start_t + i_1.data.fade_in + i_1.data.sustain or l_9_3 and not i_1.data.play_paused or l_9_1 < l_9_12.start_t + i_1.data.fade_in + i_1.data.sustain then
					do return end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_9_3 and not i_1.data.play_paused or l_9_1 < l_9_12.start_t + i_1.data.fade_in + i_1.data.sustain + l_9_14.fade_out then
					do return end
				end
				l_9_0._ws:panel():remove(l_9_13.rectangle)
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if nil then
					l_9_13.current_alpha = nil * l_9_16.color.alpha
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_9_13.rectangle:set_color(l_9_16.color:with_alpha(nil * l_9_16.color.alpha))
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 41 
end

CoreOverlayEffectManager.paused_update = function(l_10_0, l_10_1, l_10_2)
	l_10_0:check_pause_state(true)
	l_10_0:progress_effects(l_10_1, l_10_2, true)
end

CoreOverlayEffectManager.check_pause_state = function(l_11_0, l_11_1)
	local l_11_5, l_11_6, l_11_7, l_11_8, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16, l_11_17 = nil
	if l_11_0._paused and not l_11_1 then
		for i_0,i_1 in pairs(l_11_0._playing_effects) do
			i_1.rectangle:show()
		end
		l_11_0._paused = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	do return end
	if l_11_1 then
		for i_0,i_1 in pairs(l_11_0._playing_effects) do
			if not l_11_11.data.play_paused then
				l_11_11.rectangle:hide()
			end
		end
		l_11_0._paused = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreOverlayEffectManager.play_effect = function(l_12_0, l_12_1)
	local l_12_9 = nil
	if l_12_1.fade_in <= 0 or not 0 then
		local l_12_2 = l_12_1.color.alpha * (not l_12_1 or 1)
	end
	local l_12_3, l_12_4 = l_12_0._ws:panel():rect, l_12_0._ws:panel()
	local l_12_5 = {}
	l_12_5.w = RenderSettings.resolution.x
	l_12_5.h = RenderSettings.resolution.y
	local l_12_8 = l_12_1.color:with_alpha
	l_12_8 = l_12_8(l_12_1.color, l_12_2)
	l_12_5.color = l_12_8
	l_12_3 = l_12_3(l_12_4, l_12_5)
	l_12_4, l_12_5 = l_12_3:set_layer, l_12_3
	l_12_8 = l_12_0._default_layer
	l_12_4(l_12_5, l_12_8)
	l_12_4, l_12_5 = l_12_3:set_blend_mode, l_12_3
	l_12_8 = l_12_1.blend_mode
	l_12_4(l_12_5, l_12_8)
	l_12_4 = l_12_1.play_paused
	if not l_12_4 then
		l_12_4 = l_12_0._paused
	if not l_12_4 then
		end
	end
	l_12_4, l_12_5 = l_12_3:show, l_12_3
	l_12_4(l_12_5)
	do return end
	l_12_4, l_12_5 = l_12_3:hide, l_12_3
	l_12_4(l_12_5)
	l_12_5 = l_12_1.timer
	if not l_12_5 then
		l_12_5 = TimerManager
		l_12_5, l_12_8 = l_12_5:game, l_12_5
		l_12_5 = l_12_5(l_12_8)
	end
	l_12_5, l_12_8 = l_12_5:time, l_12_5
	l_12_5 = l_12_5(l_12_8)
	l_12_5 = {}
	l_12_5 = pairs
	l_12_8 = l_12_1
	l_12_5 = l_12_5(l_12_8)
	for i_0,i_1 in l_12_5 do
		l_12_4.data[l_12_7] = i_1
	end
	while 1 do
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_12_0._playing_effects[1] then
		end
	end
	table.insert(l_12_0._playing_effects, 1 + 1, l_12_4)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return 1 + 1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	do return end
	l_12_2 = cat_error
	l_12_3 = "georgios"
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_12_2(l_12_3, l_12_4)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreOverlayEffectManager.stop_effect = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10 = nil
	if l_13_1 and l_13_0._playing_effects[l_13_1] then
		l_13_0._ws:panel():remove(l_13_0._playing_effects[l_13_1].rectangle)
		l_13_0._playing_effects[l_13_1] = nil
	end
	do return end
	for i_0,i_1 in pairs(l_13_0._playing_effects) do
		l_13_0._ws:panel():remove(i_1.rectangle)
		l_13_0._playing_effects[i_0] = nil
	end
end

CoreOverlayEffectManager.fade_out_effect = function(l_14_0, l_14_1)
	if l_14_1 then
		local l_14_2 = l_14_0._playing_effects[l_14_1]
		if l_14_2 then
			if not l_14_2.data.timer then
				l_14_2.start_t = TimerManager:game():time()
				l_14_2.data.sustain = 0
				l_14_2.data.fade_in = 0
				local l_14_6, l_14_8, l_14_10, l_14_12, l_14_14, l_14_16, l_14_18, l_14_20, l_14_22, l_14_24 = l_14_2.data, l_14_2.data.color:with_alpha, l_14_2.data.color
				l_14_12 = l_14_2.current_alpha
				local l_14_7, l_14_9, l_14_11, l_14_13, l_14_15, l_14_17, l_14_19, l_14_21, l_14_23, l_14_25 = nil
				l_14_8 = l_14_8(l_14_10, l_14_12)
				l_14_6.color = l_14_8
			end
		else
			for i_0,i_1 in pairs(l_14_0._playing_effects) do
				if not i_1.data.timer then
					i_1.start_t = TimerManager:game():time()
					i_1.data.sustain = 0
					i_1.data.fade_in = 0
					i_1.data.color = i_1.data.color:with_alpha(i_1.current_alpha)
				end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 14 40 
end

CoreOverlayEffectManager.change_resolution = function(l_15_0)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	local l_15_1 = RenderSettings.resolution
	for i_0,i_1 in pairs(l_15_0._playing_effects) do
		local l_15_11 = i_1.rectangle:configure
		l_15_11(i_1.rectangle, {w = l_15_1.x, h = l_15_1.y})
	end
end


