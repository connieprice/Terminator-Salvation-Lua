core:module("CoreModeTimingBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
ModeTimingBox = ModeTimingBox or CoreClass.class()
function ModeTimingBox.init(A0_0, ...)
	local L2_2, L3_3
	L2_2 = CoreKeywordArguments
	L2_2 = L2_2.KeywordArguments
	L3_3 = L2_2
	L2_2 = L2_2.new
	L2_2 = L2_2(L3_3, ...)
	L3_3 = L2_2.mandatory_object
	L3_3 = L3_3(L2_2, "parent")
	A0_0._ews_parent = L3_3
	L3_3 = L2_2.assert_all_consumed
	L3_3(L2_2)
	A0_0._song_project = nil
	L3_3 = EWS
	L3_3 = L3_3.Panel
	L3_3 = L3_3(L3_3, A0_0._ews_parent, "", "")
	A0_0.panel = L3_3
	L3_3 = EWS
	L3_3 = L3_3.SpinCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, 4, "", "")
	A0_0.mode_time_signature_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "100", "", "")
	A0_0.mode_bpm_ctrl = L3_3
	L3_3 = A0_0.mode_time_signature_ctrl
	L3_3 = L3_3.set_range
	L3_3(L3_3, 1, 9)
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_time_signature")
	A0_0._on_time_signature_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_bpm")
	A0_0._on_bpm_cb = L3_3
	L3_3 = A0_0._enable_callbacks
	L3_3(A0_0)
	L3_3 = EWS
	L3_3 = L3_3.FlexGridSizer
	L3_3 = L3_3(L3_3, 3, 2, 5, 5)
	L3_3:add(EWS:StaticText(A0_0.panel, "", "", ""), 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "", "", ""), 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "          Mode Time Signature (n/4):", "", ""), 0, 0, "ALIGN_RIGHT")
	L3_3:add(A0_0.mode_time_signature_ctrl, 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "          Mode BPM:", "", ""), 0, 0, "ALIGN_RIGHT")
	L3_3:add(A0_0.mode_bpm_ctrl, 0, 0, "")
	A0_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_0.box_sizer:add(L3_3, 0, 0, "")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0:_set_enabled(false)
end
function ModeTimingBox.global_redraw(A0_4, A1_5)
	A0_4._song_project = A1_5 or assert(A0_4._song_project)
	if A0_4._mode_name then
		if not A0_4._song_project:find_mode({
			name = A0_4._mode_name
		}) then
			A0_4._mode_name = nil
		end
	end
	A0_4:_redraw()
end
function ModeTimingBox.set_song(A0_6, A1_7)
	A0_6._mode_name = nil
	A0_6._song_project = A1_7
	A0_6:_redraw()
end
function ModeTimingBox.mode_selected(A0_8, A1_9)
	A0_8._mode_name = A1_9
	A0_8:_redraw()
end
function ModeTimingBox.mode_deselected(A0_10)
	A0_10._mode_name = nil
	A0_10:_redraw()
end
function ModeTimingBox._redraw(A0_11)
	A0_11:_disable_callbacks()
	if A0_11._mode_name then
		A0_11.mode_time_signature_ctrl:set_value(A0_11._song_project:find_mode({
			name = A0_11._mode_name
		}).mode_time_signature)
		A0_11.mode_bpm_ctrl:set_value(A0_11._song_project:find_mode({
			name = A0_11._mode_name
		}).mode_bpm)
		A0_11:_set_enabled(true)
	else
		A0_11.mode_time_signature_ctrl:set_value(4)
		A0_11.mode_bpm_ctrl:set_value("100")
		A0_11:_set_enabled(false)
	end
	A0_11:_enable_callbacks()
end
function ModeTimingBox._enable_callbacks(A0_12)
	A0_12.mode_time_signature_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_12._on_time_signature_cb)
	A0_12.mode_bpm_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_12._on_bpm_cb)
end
function ModeTimingBox._disable_callbacks(A0_13)
	A0_13.mode_time_signature_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_13._on_time_signature_cb)
	A0_13.mode_bpm_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_13._on_bpm_cb)
end
function ModeTimingBox._set_enabled(A0_14, A1_15)
	A0_14.mode_time_signature_ctrl:set_enabled(A1_15)
	A0_14.mode_bpm_ctrl:set_enabled(A1_15)
end
function ModeTimingBox._on_bpm(A0_16)
	if A0_16._mode_name and tonumber(A0_16.mode_bpm_ctrl:get_value()) then
		A0_16._song_project:set_mode_parameter({
			mode_name = A0_16._mode_name,
			parameter = "mode_bpm",
			value = A0_16.mode_bpm_ctrl:get_value()
		})
	end
end
function ModeTimingBox._on_time_signature(A0_17)
	if A0_17._mode_name and tonumber(A0_17.mode_time_signature_ctrl:get_value()) then
		A0_17._song_project:set_mode_parameter({
			mode_name = A0_17._mode_name,
			parameter = "mode_time_signature",
			value = tostring(A0_17.mode_time_signature_ctrl:get_value())
		})
	end
end
