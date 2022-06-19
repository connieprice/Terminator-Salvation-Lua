core:module("CoreSongCrossfadeBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
if not SongCrossfadeBox then
	SongCrossfadeBox = CoreClass.class()
end
SongCrossfadeBox.init = function(l_1_0, ...)
	l_1_0._ews_parent = CoreKeywordArguments.KeywordArguments:new(...):mandatory_object("parent")
	CoreKeywordArguments.KeywordArguments:new(...):assert_all_consumed()
	l_1_0._song_project = nil
	l_1_0.panel = EWS:Panel(l_1_0._ews_parent, "", "")
	l_1_0.song_change_fadein_ctrl = EWS:TextCtrl(l_1_0.panel, "0.00", "", "")
	l_1_0.song_change_fadeout_ctrl = EWS:TextCtrl(l_1_0.panel, "0.00", "", "")
	l_1_0._on_change_fadein_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_change_fadein")
	l_1_0._on_change_fadeout_cb = CoreEvent.callback(l_1_0, l_1_0, "_on_change_fadeout")
	l_1_0:_enable_callbacks()
	local l_1_2 = nil
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "", "", ""), 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "          Fade-in (used when changing to this Song and Mode):", "", ""), 0, 0, "ALIGN_RIGHT")
	EWS:FlexGridSizer(3, 2, 5, 5):add(l_1_0.song_change_fadein_ctrl, 0, 0, "")
	EWS:FlexGridSizer(3, 2, 5, 5):add(EWS:StaticText(l_1_0.panel, "          Fade-out (used when changing from this Song and Mode):", "", ""), 0, 0, "ALIGN_RIGHT")
	EWS:FlexGridSizer(3, 2, 5, 5):add(l_1_0.song_change_fadeout_ctrl, 0, 0, "")
	l_1_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	l_1_0.box_sizer:add(EWS:FlexGridSizer(3, 2, 5, 5), 0, 0, "")
	l_1_0.panel:set_sizer(l_1_0.box_sizer)
	l_1_0:_set_enabled(false)
end

SongCrossfadeBox.global_redraw = function(l_2_0, l_2_1)
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

SongCrossfadeBox.mode_selected = function(l_3_0, l_3_1)
	l_3_0._mode_name = l_3_1
	l_3_0:_redraw()
end

SongCrossfadeBox.mode_deselected = function(l_4_0)
	l_4_0._mode_name = nil
	l_4_0:_redraw()
end

SongCrossfadeBox._redraw = function(l_5_0)
	l_5_0:_disable_callbacks()
	if l_5_0._mode_name then
		local l_5_1, l_5_2 = l_5_0._song_project:find_mode, l_5_0._song_project
		local l_5_3 = {}
		l_5_3.name = l_5_0._mode_name
		l_5_1 = l_5_1(l_5_2, l_5_3)
		l_5_2 = l_5_0.song_change_fadein_ctrl
		l_5_2, l_5_3 = l_5_2:set_value, l_5_2
		l_5_2(l_5_3, l_5_1.song_change_fadein)
		l_5_2 = l_5_0.song_change_fadeout_ctrl
		l_5_2, l_5_3 = l_5_2:set_value, l_5_2
		l_5_2(l_5_3, l_5_1.song_change_fadeout)
		l_5_2, l_5_3 = l_5_0:_set_enabled, l_5_0
		l_5_2(l_5_3, true)
	else
		l_5_0.song_change_fadein_ctrl:set_value("0.00")
		l_5_0.song_change_fadeout_ctrl:set_value("0.00")
		l_5_0:_set_enabled(false)
	end
	l_5_0:_enable_callbacks()
end

SongCrossfadeBox._enable_callbacks = function(l_6_0)
	l_6_0.song_change_fadein_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_6_0._on_change_fadein_cb)
	l_6_0.song_change_fadeout_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", l_6_0._on_change_fadeout_cb)
end

SongCrossfadeBox._disable_callbacks = function(l_7_0)
	l_7_0.song_change_fadein_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_7_0._on_change_fadein_cb)
	l_7_0.song_change_fadeout_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", l_7_0._on_change_fadeout_cb)
end

SongCrossfadeBox._set_enabled = function(l_8_0, l_8_1)
	l_8_0.song_change_fadein_ctrl:set_enabled(l_8_1)
	l_8_0.song_change_fadeout_ctrl:set_enabled(l_8_1)
end

SongCrossfadeBox._on_change_fadein = function(l_9_0)
	if l_9_0._mode_name and tonumber(l_9_0.song_change_fadein_ctrl:get_value()) then
		local l_9_1, l_9_2 = l_9_0._song_project:set_mode_parameter, l_9_0._song_project
		local l_9_3 = {}
		l_9_3.mode_name = l_9_0._mode_name
		l_9_3.parameter = "song_change_fadein"
		l_9_3.value = l_9_0.song_change_fadein_ctrl:get_value()
		l_9_1(l_9_2, l_9_3)
	end
end

SongCrossfadeBox._on_change_fadeout = function(l_10_0)
	if l_10_0._mode_name and tonumber(l_10_0.song_change_fadeout_ctrl:get_value()) then
		local l_10_1, l_10_2 = l_10_0._song_project:set_mode_parameter, l_10_0._song_project
		local l_10_3 = {}
		l_10_3.mode_name = l_10_0._mode_name
		l_10_3.parameter = "song_change_fadeout"
		l_10_3.value = l_10_0.song_change_fadeout_ctrl:get_value()
		l_10_1(l_10_2, l_10_3)
	end
end


