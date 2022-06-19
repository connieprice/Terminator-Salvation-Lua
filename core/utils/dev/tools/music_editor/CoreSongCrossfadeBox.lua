core:module("CoreSongCrossfadeBox")
core:require_module("CoreKeywordArguments")
core:require_module("CoreClass")
core:require_module("CoreEvent")
SongCrossfadeBox = SongCrossfadeBox or CoreClass.class()
function SongCrossfadeBox.init(A0_0, ...)
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
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0.00", "", "")
	A0_0.song_change_fadein_ctrl = L3_3
	L3_3 = EWS
	L3_3 = L3_3.TextCtrl
	L3_3 = L3_3(L3_3, A0_0.panel, "0.00", "", "")
	A0_0.song_change_fadeout_ctrl = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_change_fadein")
	A0_0._on_change_fadein_cb = L3_3
	L3_3 = CoreEvent
	L3_3 = L3_3.callback
	L3_3 = L3_3(A0_0, A0_0, "_on_change_fadeout")
	A0_0._on_change_fadeout_cb = L3_3
	L3_3 = A0_0._enable_callbacks
	L3_3(A0_0)
	L3_3 = EWS
	L3_3 = L3_3.FlexGridSizer
	L3_3 = L3_3(L3_3, 3, 2, 5, 5)
	L3_3:add(EWS:StaticText(A0_0.panel, "", "", ""), 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "", "", ""), 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "          Fade-in (used when changing to this Song and Mode):", "", ""), 0, 0, "ALIGN_RIGHT")
	L3_3:add(A0_0.song_change_fadein_ctrl, 0, 0, "")
	L3_3:add(EWS:StaticText(A0_0.panel, "          Fade-out (used when changing from this Song and Mode):", "", ""), 0, 0, "ALIGN_RIGHT")
	L3_3:add(A0_0.song_change_fadeout_ctrl, 0, 0, "")
	A0_0.box_sizer = EWS:BoxSizer("HORIZONTAL")
	A0_0.box_sizer:add(L3_3, 0, 0, "")
	A0_0.panel:set_sizer(A0_0.box_sizer)
	A0_0:_set_enabled(false)
end
function SongCrossfadeBox.global_redraw(A0_4, A1_5)
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
function SongCrossfadeBox.mode_selected(A0_6, A1_7)
	A0_6._mode_name = A1_7
	A0_6:_redraw()
end
function SongCrossfadeBox.mode_deselected(A0_8)
	A0_8._mode_name = nil
	A0_8:_redraw()
end
function SongCrossfadeBox._redraw(A0_9)
	A0_9:_disable_callbacks()
	if A0_9._mode_name then
		A0_9.song_change_fadein_ctrl:set_value(A0_9._song_project:find_mode({
			name = A0_9._mode_name
		}).song_change_fadein)
		A0_9.song_change_fadeout_ctrl:set_value(A0_9._song_project:find_mode({
			name = A0_9._mode_name
		}).song_change_fadeout)
		A0_9:_set_enabled(true)
	else
		A0_9.song_change_fadein_ctrl:set_value("0.00")
		A0_9.song_change_fadeout_ctrl:set_value("0.00")
		A0_9:_set_enabled(false)
	end
	A0_9:_enable_callbacks()
end
function SongCrossfadeBox._enable_callbacks(A0_10)
	A0_10.song_change_fadein_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_10._on_change_fadein_cb)
	A0_10.song_change_fadeout_ctrl:connect("EVT_COMMAND_TEXT_UPDATED", A0_10._on_change_fadeout_cb)
end
function SongCrossfadeBox._disable_callbacks(A0_11)
	A0_11.song_change_fadein_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_11._on_change_fadein_cb)
	A0_11.song_change_fadeout_ctrl:disconnect("EVT_COMMAND_TEXT_UPDATED", A0_11._on_change_fadeout_cb)
end
function SongCrossfadeBox._set_enabled(A0_12, A1_13)
	A0_12.song_change_fadein_ctrl:set_enabled(A1_13)
	A0_12.song_change_fadeout_ctrl:set_enabled(A1_13)
end
function SongCrossfadeBox._on_change_fadein(A0_14)
	if A0_14._mode_name and tonumber(A0_14.song_change_fadein_ctrl:get_value()) then
		A0_14._song_project:set_mode_parameter({
			mode_name = A0_14._mode_name,
			parameter = "song_change_fadein",
			value = A0_14.song_change_fadein_ctrl:get_value()
		})
	end
end
function SongCrossfadeBox._on_change_fadeout(A0_15)
	if A0_15._mode_name and tonumber(A0_15.song_change_fadeout_ctrl:get_value()) then
		A0_15._song_project:set_mode_parameter({
			mode_name = A0_15._mode_name,
			parameter = "song_change_fadeout",
			value = A0_15.song_change_fadeout_ctrl:get_value()
		})
	end
end
