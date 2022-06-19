core:module("CoreModeTimingBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not ModeTimingBox then
	ModeTimingBox = CoreClass.class()
end
ModeTimingBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0.mode_time_signature_ctrl = EWS:SpinCtrl(l_1_0.panel, 4, "", "")
	l_1_0.mode_bpm_ctrl = EWS:TextCtrl(l_1_0.panel, "100", "", "")
	l_1_0.mode_time_signature_ctrl:set_range(1, 9)
	l_1_0._on_time_signature_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_time_signature")
	l_1_0._on_bpm_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_bpm")
	l_1_0:_enable_callbacks()
	local l_1_2 = nil
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "          Mode Time Signature (n/4):", "", ""), 0, 0, "ALIGN_RIGHT")
	EWS:FlexGridSizer(3, 2, 5, 5):add(l_1_0.mode_time_signature_ctrl, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "          Mode BPM:", "", ""), 0, 0, "ALIGN_RIGHT")
	EWS:FlexGridSizer(3, 2, 5, 5):add(l_1_0.mode_bpm_ctrl, 0, 0, "")
	l_1_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	l_1_0.box_sizer:add(EWS:FlexGridSizer(3, 2, 5, 5), 0, 0, "")
	l_1_0.panel:set_sizer(l_1_0.box_sizer)
	l_1_0:_set_enabled(false)
end

ModeTimingBox.global_redraw = function(l_2_0, l_2_1)
	do
		if not l_2_1 then
			l_2_0._song_project = assert(l_2_0._song_project)
		end
		if l_2_0._mode_name then
			local l_2_3 = l_2_0._song_project:find_mode
			local l_2_4 = l_2_0._song_project
			l_2_3 = l_2_3(l_2_4, {name = l_2_0._mode_name})
		if not l_2_3 then
			end
			l_2_0._mode_name = nil
		end
		l_2_0:_redraw()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ModeTimingBox.set_song = function(l_3_0, l_3_1)
	l_3_0._mode_name = nil
	l_3_0._song_project = l_3_1
	l_3_0:_redraw()
end

ModeTimingBox.mode_selected = function(l_4_0, l_4_1)
	l_4_0._mode_name = l_4_1
	l_4_0:_redraw()
end

ModeTimingBox.mode_deselected = function(l_5_0)
	l_5_0._mode_name = nil
	l_5_0:_redraw()
end

ModeTimingBox._redraw = function(l_6_0)
	l_6_0:_disable_callbacks()
	if l_6_0._mode_name then
		local l_6_1, l_6_2 = l_6_0._song_project:find_mode, l_6_0._song_project
		local l_6_3 = {}
		l_6_3.name = l_6_0._mode_name
		l_6_1 = l_6_1(l_6_2, l_6_3)
		l_6_2 = l_6_0.mode_time_signature_ctrl
		l_6_2, l_6_3 = l_6_2:set_value, l_6_2
		l_6_2(l_6_3, l_6_1.mode_time_signature)
		l_6_2 = l_6_0.mode_bpm_ctrl
		l_6_2, l_6_3 = l_6_2:set_value, l_6_2
		l_6_2(l_6_3, l_6_1.mode_bpm)
		l_6_2, l_6_3 = l_6_0:_set_enabled, l_6_0
		l_6_2(l_6_3, true)
	else
		l_6_0.mode_time_signature_ctrl:set_value(4)
		l_6_0.mode_bpm_ctrl:set_value("100")
		l_6_0:_set_enabled(false)
	end
	l_6_0:_enable_callbacks()
end

ModeTimingBox._enable_callbacks = function(l_7_0)
	l_7_0.mode_time_signature_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_7_0._on_time_signature_cb)
	l_7_0.mode_bpm_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_7_0._on_bpm_cb)
end

ModeTimingBox._disable_callbacks = function(l_8_0)
	l_8_0.mode_time_signature_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_8_0._on_time_signature_cb)
	l_8_0.mode_bpm_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_8_0._on_bpm_cb)
end

ModeTimingBox._set_enabled = function(l_9_0, l_9_1)
	l_9_0.mode_time_signature_ctrl:set_enabled(l_9_1)
	l_9_0.mode_bpm_ctrl:set_enabled(l_9_1)
end

ModeTimingBox._on_bpm = function(l_10_0)
	if l_10_0._mode_name and tonumber(l_10_0.mode_bpm_ctrl:get_value()) then
		local l_10_1, l_10_2 = l_10_0._song_project:set_mode_parameter, l_10_0._song_project
		local l_10_3 = {}
		l_10_3.mode_name = l_10_0._mode_name
		l_10_3.parameter = "mode_bpm"
		l_10_3.value = l_10_0.mode_bpm_ctrl:get_value()
		l_10_1(l_10_2, l_10_3)
	end
end

ModeTimingBox._on_time_signature = function(l_11_0)
	if l_11_0._mode_name and tonumber(l_11_0.mode_time_signature_ctrl:get_value()) then
		local l_11_1, l_11_2 = l_11_0._song_project:set_mode_parameter, l_11_0._song_project
		local l_11_3 = {}
		l_11_3.mode_name = l_11_0._mode_name
		l_11_3.parameter = "mode_time_signature"
		l_11_3.value = tostring(l_11_0.mode_time_signature_ctrl:get_value())
		l_11_1(l_11_2, l_11_3)
	end
end


