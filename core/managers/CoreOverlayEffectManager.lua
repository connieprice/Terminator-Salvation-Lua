CoreOverlayEffectManager = CoreOverlayEffectManager or class()
function CoreOverlayEffectManager.init(A0_0)
	A0_0._vp_overlay = Application:create_scene_viewport(0, 0, 1, 1)
	A0_0._overlay_camera = Overlay:create_camera()
	A0_0._vp_overlay:set_camera(A0_0._overlay_camera)
	A0_0._ws = Overlay:newgui():create_screen_workspace()
	A0_0._ws:set_timer(TimerManager:main())
	A0_0._playing_effects = {}
	A0_0._paused = nil
	A0_0._presets = {}
	A0_0:add_preset("custom", {
		blend_mode = "normal",
		sustain = 0,
		fade_in = 0,
		fade_out = 0,
		color = Color(1, 0, 0, 0)
	})
	A0_0:set_default_layer(30)
	managers.viewport:add_resolution_changed_func(callback(A0_0, A0_0, "change_resolution"))
end
function CoreOverlayEffectManager.set_visible(A0_1, A1_2)
	A0_1._ws:panel():set_visible(A1_2)
end
function CoreOverlayEffectManager.add_preset(A0_3, A1_4, A2_5)
	A0_3._presets[A1_4] = A2_5
end
function CoreOverlayEffectManager.presets(A0_6)
	local L1_7
	L1_7 = A0_6._presets
	return L1_7
end
function CoreOverlayEffectManager.set_default_layer(A0_8, A1_9)
	A0_8._default_layer = A1_9
end
function CoreOverlayEffectManager.update(A0_10, A1_11, A2_12)
	A0_10._vp_overlay:update()
	A0_10:check_pause_state()
	A0_10:progress_effects(A1_11, A2_12)
end
function CoreOverlayEffectManager.destroy(A0_13)
	if CoreCode.alive(A0_13._overlay_camera) then
		Overlay:delete_camera(A0_13._overlay_camera)
		A0_13._overlay_camera = nil
	end
	if A0_13._vp_overlay then
		Application:destroy_viewport(A0_13._vp_overlay)
		A0_13._vp_overlay = nil
	end
	if CoreCode.alive(A0_13._ws) then
		Overlay:newgui():destroy_workspace(A0_13._ws)
		A0_13._ws = nil
	end
end
function CoreOverlayEffectManager.render(A0_14)
	if script_debug.render_overlay then
		Application:render("Overlay", A0_14._vp_overlay)
	end
end
function CoreOverlayEffectManager.progress_effects(A0_15, A1_16, A2_17, A3_18)
	local L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27, L13_28, L14_29
	for L7_22, L8_23 in L4_19(L5_20) do
		L9_24 = L8_23.data
		if A3_18 then
			L10_25 = L9_24.play_paused
		elseif L10_25 then
			L10_25 = L9_24.timer
			if L10_25 then
				L10_25 = L9_24.timer
				L11_26 = L10_25
				L10_25 = L10_25.time
				L10_25 = L10_25(L11_26)
			elseif not L10_25 then
				if A3_18 then
					L10_25 = TimerManager
					L11_26 = L10_25
					L10_25 = L10_25.game
					L10_25 = L10_25(L11_26)
					L11_26 = L10_25
					L10_25 = L10_25.time
					L10_25 = L10_25(L11_26)
				else
					L10_25 = L10_25 or A1_16
				end
			end
			L11_26 = L8_23.start_t
			L12_27 = L9_24.fade_in
			L11_26 = L11_26 + L12_27
			L12_27 = L9_24.sustain
			if L12_27 then
				L12_27 = L9_24.sustain
				L12_27 = L11_26 + L12_27
			end
			L13_28 = L12_27 and L12_27 + L13_28
			L14_29 = nil
			if L10_25 < L11_26 then
				L14_29 = (L10_25 - L8_23.start_t) / L9_24.fade_in
			elseif not L12_27 or L10_25 < L12_27 then
				L14_29 = 1
			elseif L10_25 < L13_28 then
				L14_29 = 1 - (L10_25 - L12_27) / L9_24.fade_out
			else
				A0_15._ws:panel():remove(L8_23.rectangle)
				A0_15._playing_effects[L7_22] = nil
			end
			if L14_29 then
				L14_29 = L14_29 * L9_24.color.alpha
				L8_23.current_alpha = L14_29
				L8_23.rectangle:set_color(L9_24.color:with_alpha(L14_29))
			end
		end
	end
end
function CoreOverlayEffectManager.paused_update(A0_30, A1_31, A2_32)
	A0_30:check_pause_state(true)
	A0_30:progress_effects(A1_31, A2_32, true)
end
function CoreOverlayEffectManager.check_pause_state(A0_33, A1_34)
	if A0_33._paused then
		if not A1_34 then
			for 