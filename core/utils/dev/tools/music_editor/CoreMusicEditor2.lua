core:module("CoreMusicEditor2")
core:require_module("CoreStartStopBox")
core:require_module("CoreSongCrossfadeBox")
core:require_module("CoreModeCrossfadeBox")
core:require_module("CoreModeTimingBox")
core:require_module("CoreMarkersBox")
core:require_module("CoreMarkerEditBox")
core:require_module("CoreClipsBox")
core:require_module("CoreModesBox")
core:require_module("CoreSongProject")
core:require_module("CoreSongExporter")
core:require_module("CoreClass")
core:require_module("CoreEvent")
TOOLHUB_NAME = "Music Editor"
CoreMusicEditor2 = CoreMusicEditor2 or CoreClass.class()
function CoreMusicEditor2.init(A0_0)
	A0_0._song_project = nil
	A0_0._database = ProjectDatabase
	A0_0:_create_main_frame()
end
function CoreMusicEditor2._create_main_frame(A0_1)
	local L1_2, L2_3, L3_4, L4_5, L5_6
	L1_2 = EWS
	L2_3 = L1_2
	L1_2 = L1_2.Frame
	L3_4 = TOOLHUB_NAME
	L4_5 = Vector3
	L5_6 = 100
	L4_5 = L4_5(L5_6, 400, 0)
	L5_6 = Vector3
	L5_6 = L5_6(690, 470, 0)
	L1_2 = L1_2(L2_3, L3_4, L4_5, L5_6, "FRAME_FLOAT_ON_PARENT,DEFAULT_FRAME_STYLE", Global.frame)
	A0_1._frame = L1_2
	L1_2 = EWS
	L2_3 = L1_2
	L1_2 = L1_2.BoxSizer
	L3_4 = "VERTICAL"
	L1_2 = L1_2(L2_3, L3_4)
	L2_3 = EWS
	L3_4 = L2_3
	L2_3 = L2_3.SplitterWindow
	L4_5 = A0_1._frame
	L5_6 = ""
	L2_3 = L2_3(L3_4, L4_5, L5_6, "")
	L3_4 = EWS
	L4_5 = L3_4
	L3_4 = L3_4.SplitterWindow
	L5_6 = L2_3
	L3_4 = L3_4(L4_5, L5_6, "", "")
	L4_5 = EWS
	L5_6 = L4_5
	L4_5 = L4_5.SplitterWindow
	L4_5 = L4_5(L5_6, L3_4, "", "")
	L5_6 = EWS
	L5_6 = L5_6.Notebook
	L5_6 = L5_6(L5_6, A0_1._frame, "", "")
	A0_1:_create_menu(A0_1._frame)
	A0_1._met = {}
	A0_1._met.startstop = CoreStartStopBox.StartStopBox:new({parent = L5_6})
	A0_1._met.modecrossfade = CoreModeCrossfadeBox.ModeCrossfadeBox:new({parent = L5_6})
	A0_1._met.modetiming = CoreModeTimingBox.ModeTimingBox:new({parent = L5_6})
	A0_1._met.songcrossfade = CoreSongCrossfadeBox.SongCrossfadeBox:new({parent = L5_6})
	A0_1._met.marker_edit = CoreMarkerEditBox.MarkerEditBox:new({parent = L3_4})
	A0_1._met.markers = CoreMarkersBox.MarkersBox:new({
		parent = L2_3,
		marker_edit = A0_1._met.marker_edit,
		modecrossfade = A0_1._met.modecrossfade,
		main_redraw_cb = CoreEvent.callback(A0_1, A0_1, "_global_redraw")
	})
	A0_1._met.clips = CoreClipsBox.ClipsBox:new({
		parent = L4_5,
		markers = A0_1._met.markers,
		marker_edit = A0_1._met.marker_edit
	})
	A0_1._met.modes = CoreModesBox.ModesBox:new({
		parent = L4_5,
		clips = A0_1._met.clips,
		markers = A0_1._met.markers,
		startstop = A0_1._met.startstop,
		modetiming = A0_1._met.modetiming,
		songcrossfade = A0_1._met.songcrossfade
	})
	L2_3:split_vertically(L3_4, A0_1._met.markers.panel, "")
	L2_3:set_minimum_pane_size(50)
	L2_3:set_sash_gravity(1)
	L2_3:set_sash_position(550, true)
	L3_4:split_horizontally(L4_5, A0_1._met.marker_edit.panel, "")
	L3_4:set_minimum_pane_size(100)
	L3_4:set_sash_gravity(1)
	L3_4:set_sash_position(140, true)
	L4_5:split_vertically(A0_1._met.modes.panel, A0_1._met.clips.panel, "")
	L4_5:set_minimum_pane_size(50)
	L4_5:set_sash_position(110, true)
	L5_6:add_page(A0_1._met.startstop.panel, "Mode Start/Stop", true)
	L5_6:add_page(A0_1._met.modecrossfade.panel, "Mode Change", false)
	L5_6:add_page(A0_1._met.modetiming.panel, "Mode Timing", false)
	L5_6:add_page(A0_1._met.songcrossfade.panel, "Song Change", false)
	L1_2:add(L2_3, 1, 0, "EXPAND")
	L1_2:add(L5_6, 0, 0, "EXPAND")
	A0_1._frame:set_sizer(L1_2)
	A0_1._frame:set_visible(true)
end
function CoreMusicEditor2._create_menu(A0_7, A1_8)
	local L2_9, L3_10
	L2_9 = EWS
	L3_10 = L2_9
	L2_9 = L2_9.Menu
	L2_9 = L2_9(L3_10, "")
	L3_10 = L2_9.append_item
	L3_10(L2_9, "NEW", "New\tCtrl+N", "")
	L3_10 = L2_9.append_item
	L3_10(L2_9, "OPEN", "Open\tCtrl+O", "")
	L3_10 = L2_9.append_item
	L3_10(L2_9, "SAVE", "Save (and Export)\tCtrl+S", "")
	L3_10 = L2_9.append_item
	L3_10(L2_9, "SAVE_AS", "Save As (and Export)", "")
	L3_10 = L2_9.append_item
	L3_10(L2_9, "EXIT", "Exit", "")
	L3_10 = EWS
	L3_10 = L3_10.Menu
	L3_10 = L3_10(L3_10, "")
	A0_7.edit_menu = L3_10
	L3_10 = A0_7.edit_menu
	L3_10 = L3_10.append_item
	L3_10(L3_10, "UNDO", "Undo\tCtrl+Z", "")
	L3_10 = A0_7.edit_menu
	L3_10 = L3_10.append_item
	L3_10(L3_10, "REDO", "Redo\tCtrl+Y", "")
	L3_10 = A0_7.edit_menu
	L3_10 = L3_10.set_enabled
	L3_10(L3_10, "UNDO", false)
	L3_10 = A0_7.edit_menu
	L3_10 = L3_10.set_enabled
	L3_10(L3_10, "REDO", false)
	L3_10 = EWS
	L3_10 = L3_10.MenuBar
	L3_10 = L3_10(L3_10)
	L3_10:append(L2_9, "File")
	L3_10:append(A0_7.edit_menu, "Edit")
	A1_8:set_menu_bar(L3_10)
	A1_8:connect("NEW", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_new"), "")
	A1_8:connect("OPEN", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_open"), "")
	A1_8:connect("SAVE", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_save"), "")
	A1_8:connect("SAVE_AS", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_save_as"), "")
	A1_8:connect("EXIT", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_close"), "")
	A1_8:connect("", "EVT_CLOSE_WINDOW", CoreEvent.callback(A0_7, A0_7, "_on_close"), "")
	A1_8:connect("UNDO", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_undo"), "")
	A1_8:connect("REDO", "EVT_COMMAND_MENU_SELECTED", CoreEvent.callback(A0_7, A0_7, "_on_redo"), "")
end
function CoreMusicEditor2.close(A0_11)
	if A0_11._frame then
		A0_11._frame:destroy()
	end
	A0_11._song_project = nil
end
function CoreMusicEditor2.set_position(A0_12, A1_13)
	if A0_12._frame then
		A0_12._frame:set_position(A1_13)
	end
end
function CoreMusicEditor2.update(A0_14, A1_15, A2_16)
	if A0_14._song_project_browser and A0_14._song_project_browser:update(A1_15, A2_16) then
		A0_14._song_project_browser = nil
		A0_14._frame:set_focus()
	end
end
function CoreMusicEditor2._global_redraw(A0_17, A1_18)
	A0_17._met.modes:global_redraw(A1_18)
	A0_17._met.clips:global_redraw(A1_18)
	A0_17._met.markers:global_redraw(A1_18)
	A0_17._met.marker_edit:global_redraw(A1_18)
	A0_17._met.startstop:global_redraw(A1_18)
	A0_17._met.modecrossfade:global_redraw(A1_18)
	A0_17._met.modetiming:global_redraw(A1_18)
	A0_17._met.songcrossfade:global_redraw(A1_18)
end
function CoreMusicEditor2._on_close(A0_19)
	if A0_19:_ok_loose_data() then
		managers.toolhub:close(TOOLHUB_NAME)
	end
end
function CoreMusicEditor2._on_new(A0_20)
	if A0_20:_ok_loose_data() then
		A0_20._song_project = CoreSongProject.SongProject:new({
			song_modified_cb = CoreEvent.callback(A0_20, A0_20, "_on_song_project_modified")
		})
		A0_20._open_entry = nil
		A0_20:_on_song_project_modified()
		A0_20:_global_redraw(A0_20._song_project)
	end
end
function CoreMusicEditor2._on_open(A0_21)
	if A0_21:_ok_loose_data() then
		A0_21._song_project_browser = _G.CoreDBDialog:new("song_project", A0_21, A0_21._open_song_project, A0_21._database)
	end
end
function CoreMusicEditor2._open_song_project(A0_22)
	A0_22._open_entry = A0_22._song_project_browser:get_value()
	assert(A0_22._open_entry:valid())
	A0_22._song_project = CoreSongProject.SongProject:new({
		node = A0_22._database:load_node(A0_22._open_entry),
		song_modified_cb = CoreEvent.callback(A0_22, A0_22, "_on_song_project_modified")
	})
	A0_22:_on_song_project_modified()
	A0_22:_global_redraw(A0_22._song_project)
end
function CoreMusicEditor2._ok_loose_data(A0_23)
	if A0_23._song_project then
		if A0_23._song_project:get_number_undo() > 0 or 0 < A0_23._song_project:get_number_redo() then
			return EWS:MessageDialog(A0_23._frame, "You have unsaved changes, continue and loose information?", "Unsaved Data", ""):show_modal() == "ID_OK"
		end
	end
	return true
end
function CoreMusicEditor2._on_save(A0_24)
	local L1_25
	L1_25 = A0_24._song_project
	if L1_25 then
		L1_25 = A0_24._open_entry
		if L1_25 == nil then
			L1_25 = A0_24._on_save_as
			L1_25(A0_24)
		else
			L1_25 = A0_24._song_project
			L1_25 = L1_25.get_song
			L1_25 = L1_25(L1_25)
			A0_24._database:save_node(L1_25, A0_24._open_entry)
			A0_24._database:save()
			A0_24._song_project:clear_undo()
			A0_24:_export()
		end
	end
end
function CoreMusicEditor2._on_save_as(A0_26)
	local L1_27, L2_28, L3_29
	L1_27 = A0_26._song_project
	if L1_27 then
		L1_27 = ""
		L2_28 = A0_26._open_entry
		if L2_28 then
			L2_28 = A0_26._open_entry
			L3_29 = L2_28
			L2_28 = L2_28.name
			L2_28 = L2_28(L3_29)
			L1_27 = L2_28
		end
		L2_28 = false
		while not L2_28 do
			L3_29 = EWS
			L3_29 = L3_29.get_text_from_user
			L3_29 = L3_29(L3_29, A0_26._frame, "Enter new Song Project name:", "Save as", L1_27, Vector3(-1, -1, 0), true)
			L1_27 = L3_29
			if L1_27 == nil or L1_27 == "" then
				return
			end
			L3_29 = "OBS!\n"
			L3_29 = L3_29 .. "For each Song Project there will be a Song\n"
			L3_29 = L3_29 .. "with the same name created when the Song project is Exported.\n"
			if A0_26._database:has("song_project", L1_27) then
				L3_29 = string.format([[
%s
Song Project '%s' already exist in database, overwrite?
]], L3_29, L1_27)
			end
			if A0_26._database:has("song", L1_27) then
				L3_29 = string.format([[
%s
Song '%s' already exist in database, overwrite on Export?
]], L3_29, L1_27)
			end
			if true then
				if EWS:MessageDialog(A0_26._frame, L3_29, "Overwrite?", ""):show_modal() == "ID_OK" then
					L2_28 = true
				end
			else
				L2_28 = true
			end
		end
		L3_29 = A0_26._database
		L3_29 = L3_29.has
		L3_29 = L3_29(L3_29, "song_project", L1_27)
		if L3_29 then
			L3_29 = A0_26._database
			L3_29 = L3_29.lookup
			L3_29 = L3_29(L3_29, "song_project", L1_27)
			A0_26._open_entry = L3_29
		else
			L3_29 = A0_26._database
			L3_29 = L3_29.add
			L3_29 = L3_29(L3_29, "song_project", L1_27, {}, "xml")
			A0_26._open_entry = L3_29
		end
		L3_29 = A0_26._song_project
		L3_29 = L3_29.get_song
		L3_29 = L3_29(L3_29)
		A0_26._database:save_node(L3_29, A0_26._open_entry)
		A0_26._database:save()
		A0_26._song_project:clear_undo()
		A0_26:_export()
	end
end
function CoreMusicEditor2._export(A0_30)
	local L1_31, L2_32, L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L9_39, L10_40
	L1_31 = A0_30._open_entry
	L2_32 = L1_31
	L1_31 = L1_31.name
	L1_31 = L1_31(L2_32)
	L2_32 = nil
	L3_33 = A0_30._database
	L4_34 = L3_33
	L3_33 = L3_33.has
	L5_35 = "song"
	L3_33 = L3_33(L4_34, L5_35, L6_36)
	if L3_33 then
		L3_33 = A0_30._database
		L4_34 = L3_33
		L3_33 = L3_33.lookup
		L5_35 = "song"
		L3_33 = L3_33(L4_34, L5_35, L6_36)
		L2_32 = L3_33
	else
		L3_33 = A0_30._database
		L4_34 = L3_33
		L3_33 = L3_33.add
		L5_35 = "song"
		L3_33 = L3_33(L4_34, L5_35, L6_36, L7_37, L8_38)
		L2_32 = L3_33
	end
	L3_33 = CoreSongExporter
	L3_33 = L3_33.SongExporter
	L4_34 = L3_33
	L3_33 = L3_33.new
	L5_35 = A0_30._song_project
	L3_33 = L3_33(L4_34, L5_35, L6_36)
	L5_35 = L3_33
	L4_34 = L3_33.export
	L4_34 = L4_34(L5_35, L6_36)
	if L4_34 then
		L5_35 = #L4_34
		if L5_35 > 0 then
			L5_35 = [[
Your Song was saved, but not Exported. Please Correct the following problems and try again:

]]
			for L9_39, L10_40 in L6_36(L7_37) do
				L5_35 = L5_35 .. L9_39 .. ":" .. L10_40 .. [[


]]
			end
			L9_39 = L5_35
			L10_40 = "Export Error"
			L6_36(L7_37)
		end
	end
end
function CoreMusicEditor2._on_undo(A0_41)
	if A0_41._song_project ~= nil then
		A0_41._song_project:undo()
		A0_41:_global_redraw()
	end
end
function CoreMusicEditor2._on_redo(A0_42)
	if A0_42._song_project ~= nil then
		A0_42._song_project:redo()
		A0_42:_global_redraw()
	end
end
function CoreMusicEditor2._on_song_project_modified(A0_43)
	local L1_44, L2_45, L3_46, L4_47
	L1_44 = false
	L2_45 = false
	L3_46 = "<new song project>"
	L4_47 = ""
	if A0_43._song_project ~= nil then
		L1_44 = A0_43._song_project:get_number_undo() > 0
		L2_45 = 0 < A0_43._song_project:get_number_redo()
	end
	if A0_43._open_entry then
		L3_46 = A0_43._open_entry:name()
	end
	if L1_44 or L2_45 then
		L4_47 = "*"
	end
	A0_43.edit_menu:set_enabled("UNDO", L1_44)
	A0_43.edit_menu:set_enabled("REDO", L2_45)
	A0_43._frame:set_title(string.format("%s - [%s%s]", TOOLHUB_NAME, L4_47, L3_46))
end
