require("menu/OverlayGui")
require("menu/ingame/IntroCredits")
require("menu/ingame/ChapterText")
require("menu/ingame/IoIconPanel")
require("units/beings/player/new_gui/TutorialPanel")
require("units/beings/player/new_gui/HudUtility")
require("units/beings/player/new_gui/MissionObjectivePanel")
require("units/beings/player/gui/Subtitles")
require("units/beings/player_tank/gui/BackgroundPanel")
if not IngameGui then
	IngameGui = class(OverlayGui)
end
IngameGui.init = function(l_1_0)
	OverlayGui.init(l_1_0)
	l_1_0:_preload_textures()
end

IngameGui._setup_resources = function(l_2_0)
	OverlayGui._setup_resources(l_2_0)
	local l_2_1, l_2_2 = l_2_0._workspace:panel, l_2_0._workspace
	local l_2_3 = {}
	l_2_3.valign = "grow"
	l_2_3.halign = "grow"
	l_2_1 = l_2_1(l_2_2, l_2_3)
	l_2_0._full_screen_panel = l_2_1
	l_2_1, l_2_2 = l_2_0:safe_rect, l_2_0
	l_2_1 = l_2_1(l_2_2)
	l_2_2 = l_2_0._full_screen_panel
	l_2_2, l_2_3 = l_2_2:panel, l_2_2
	local l_2_4 = {}
	l_2_4.name = "safe_panel"
	l_2_4.valign = "grow"
	l_2_4.halign = "grow"
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_0._safe_panel = l_2_2
	l_2_2 = l_2_0._safe_panel
	l_2_2, l_2_3 = l_2_2:set_shape, l_2_2
	l_2_4 = l_2_1.x
	l_2_2(l_2_3, l_2_4, l_2_1.y, l_2_1.w, l_2_1.h)
	l_2_2 = IoIconPanel
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._safe_panel
	l_2_2 = l_2_2(l_2_3, l_2_4, "gui_saving_icon", tweak_data.player.new_hud.io_icon_panel.SAVE_SPIN_SPEED)
	l_2_0._save_panel = l_2_2
	l_2_2 = IoIconPanel
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._safe_panel
	l_2_2 = l_2_2(l_2_3, l_2_4, "gui_loading_icon", tweak_data.player.new_hud.io_icon_panel.LOAD_SPIN_SPEED)
	l_2_0._load_panel = l_2_2
	l_2_2 = l_2_0._full_screen_panel
	l_2_2, l_2_3 = l_2_2:panel, l_2_2
	l_2_2, l_2_4 = l_2_2(l_2_3, l_2_4), {valign = "grow", halign = "grow"}
	l_2_0._shared_components_full_screen_panel = l_2_2
	l_2_2 = l_2_0._safe_panel
	l_2_2, l_2_3 = l_2_2:panel, l_2_2
	l_2_2, l_2_4 = l_2_2(l_2_3, l_2_4), {valign = "grow", halign = "grow"}
	l_2_0._shared_components_safe_panel = l_2_2
	l_2_2 = BackgroundPanel
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._full_screen_panel
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_0._tank_background_panel = l_2_2
	l_2_2 = Subtitles
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._shared_components_safe_panel
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_0._subtitles = l_2_2
	l_2_2 = TutorialPanel
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._shared_components_full_screen_panel
	l_2_2 = l_2_2(l_2_3, l_2_4, l_2_0._safe_panel)
	l_2_0._tutorial_panel = l_2_2
	l_2_2 = MissionObjectivePanel
	l_2_2, l_2_3 = l_2_2:new, l_2_2
	l_2_4 = l_2_0._shared_components_full_screen_panel
	l_2_2 = l_2_2(l_2_3, l_2_4, l_2_0._safe_panel)
	l_2_0._mission_obj_panel = l_2_2
end

IngameGui._shutdown_resources = function(l_3_0)
	if l_3_0._chapter_text then
		l_3_0:hide_chapter_text()
	end
	OverlayGui._shutdown_resources(l_3_0)
end

IngameGui._preload_textures = function(l_4_0)
	Overlay:gui():preload_font(tweak_data.hud.intro_credits.TEXT_FONT_NAME)
	local l_4_1 = {}
	local l_4_5 = "gui_tutorial_photo_cover"
	local l_4_6 = "gui_tutorial_note_qmtactics"
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_4_5 do
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		"gui_tutorial_photo_spider1":gui():preload_texture("gui_tutorial_photo_blindfire")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

IngameGui.show_chapter_text = function(l_5_0, l_5_1)
	assert(not l_5_0._chapter_text)
	l_5_0._chapter_text = ChapterText:new(l_5_0._shared_components_safe_panel, l_5_1)
end

IngameGui.hide_chapter_text = function(l_6_0)
	assert(l_6_0._chapter_text)
	l_6_0._chapter_text:destroy()
	l_6_0._chapter_text = nil
end

IngameGui.enable_subtitles = function(l_7_0, l_7_1)
	l_7_0._subtitles:enable_subtitles(l_7_1)
end

IngameGui._common_update = function(l_8_0, l_8_1)
	OverlayGui.update(l_8_0, l_8_1)
	if l_8_0._save_panel:next_update(l_8_1) then
		if managers.save:is_busy_saving() then
			l_8_0._save_panel:show()
		else
			l_8_0._save_panel:hide()
		end
		if l_8_0._save_panel:visible() then
			l_8_0._save_panel:update(l_8_1)
		end
	else
		l_8_0._save_panel:use_low_frequency_update(l_8_1)
	end
	if l_8_0._load_panel:next_update(l_8_1) then
		if managers.save:is_busy_loading() then
			l_8_0._load_panel:show()
		else
			l_8_0._load_panel:hide()
		end
		if l_8_0._load_panel:visible() then
			l_8_0._load_panel:update(l_8_1)
		end
	else
		l_8_0._load_panel:use_low_frequency_update(l_8_1)
	end
end

IngameGui.update = function(l_9_0, l_9_1)
	l_9_0:_common_update(l_9_1)
	if (managers.game:is_paused() or managers.game:is_frozen()) and not l_9_0._hidden then
		l_9_0:_hide_ingame_gui()
		l_9_0._hidden = true
	end
	do return end
	if l_9_0._hidden then
		l_9_0:_show_ingame_gui()
		l_9_0._hidden = false
	end
	if l_9_0._subtitles then
		l_9_0._subtitles:update(l_9_1)
	end
	if managers.game:is_in_game() and l_9_0._chapter_text then
		local l_9_2 = l_9_0._chapter_text:update(l_9_1)
	if l_9_2 then
		end
		l_9_0:hide_chapter_text()
	end
	l_9_0:_update_user_interaction(l_9_1)
	l_9_0:_update_mission_objectives(l_9_1)
	if managers.worldcamera:current_world_camera() and not l_9_0._cutscene_hidden then
		l_9_0:_hide_ingame_gui_cutscene()
		l_9_0._cutscene_hidden = true
	end
	do return end
	l_9_0:_update_tutorial_panel(l_9_1)
	l_9_0._cutscene_hidden = false
	if managers.tank_display:is_active() then
		l_9_0:_update_tank_background_panel(l_9_1)
	end
end

IngameGui._update_tutorial_panel = function(l_10_0, l_10_1)
	if l_10_0._tutorial_panel:next_update(l_10_1) then
		local l_10_2 = managers.tutorial:get_current_tutorial()
		if l_10_2 then
			if HudUtility.is_split_screen() then
				l_10_0._tutorial_panel:use_splitscreen_position()
			else
				l_10_0._tutorial_panel:use_single_player_position()
			end
		if not managers.localizer_mapping:skip_tutorial(l_10_2) then
			end
			l_10_0._tutorial_panel:show(l_10_2)
			l_10_0._tutorial_panel:update(l_10_1)
		end
	else
		if l_10_0._tutorial_panel:visible() then
			l_10_0._tutorial_panel:hide()
			l_10_0._tutorial_panel:update(l_10_1)
		end
	else
		l_10_0._tutorial_panel:use_low_frequency_update()
	end
end

IngameGui._update_mission_objectives = function(l_11_0, l_11_1)
	if l_11_0._mission_obj_panel:next_update(l_11_1) then
		local l_11_2, l_11_3 = next(managers.assigned_mission_objective:assigned_objectives())
		if l_11_3 then
			l_11_0._mission_obj_panel:show(l_11_3)
			if HudUtility.is_split_screen() then
				l_11_0._mission_obj_panel:use_splitscreen_position()
			end
		else
			l_11_0._mission_obj_panel:use_single_player_position()
		end
		if l_11_0._show_current_mission_objective then
			l_11_0._mission_obj_panel:show_current_mission_objective()
		elseif not l_11_0._show_current_mission_objective then
			l_11_0._mission_obj_panel:hide_current_mission_objective()
			l_11_0._current_mission_objective_is_showing = false
		end
		if l_11_0._mission_obj_panel:have_mission_objective() then
			l_11_0._mission_obj_panel:update(l_11_1)
		end
	if not l_11_0._mission_obj_panel:visible() then
		end
		l_11_0._mission_obj_panel:use_low_frequency_update()
	end
end

IngameGui._update_tank_background_panel = function(l_12_0, l_12_1)
	if not l_12_0._startup_initated and managers.tank_display:wants_to_startup() then
		l_12_0._tank_background_panel:startup(0, 1)
		l_12_0._startup_initated = true
	end
	if l_12_0._startup_initated and not l_12_0._startup_done then
		l_12_0._startup_done = l_12_0._tank_background_panel.startup_done
	if l_12_0._startup_done then
		end
		managers.tank_display:set_startup_done()
	end
	if not l_12_0._shuting_down and managers.tank_display:wants_to_shutdown() then
		l_12_0._tank_background_panel:shutdown(1.5, false)
		l_12_0._shuting_down = true
	end
	if (l_12_0._startup_initated and not l_12_0._startup_done) or l_12_0._shuting_down then
		l_12_0._tank_background_panel:update(l_12_1)
	end
end

IngameGui.full_screen_panel = function(l_13_0)
	return l_13_0._full_screen_panel
end

IngameGui.use_normal_font = function(l_14_0)
	l_14_0._subtitles:use_normal_font()
end

IngameGui.use_small_font = function(l_15_0)
	l_15_0._subtitles:use_small_font()
end

IngameGui._hide_ingame_gui = function(l_16_0)
	l_16_0._shared_components_full_screen_panel:hide()
	l_16_0._shared_components_safe_panel:hide()
end

IngameGui._show_ingame_gui = function(l_17_0)
	l_17_0._shared_components_full_screen_panel:show()
	l_17_0._shared_components_safe_panel:show()
	if managers.tank_display:is_active() then
		l_17_0._tank_background_panel:show()
	end
end

IngameGui._hide_ingame_gui_cutscene = function(l_18_0)
	HudUtility.hide_panel(l_18_0._tutorial_panel:panel(), true)
end

IngameGui._update_user_interaction = function(l_19_0)
	local l_19_6, l_19_7, l_19_8, l_19_9, l_19_10, l_19_11 = nil
	local l_19_1 = managers.local_user:users()
	local l_19_2 = false
	for i_0,i_1 in pairs(l_19_1) do
		if i_1:assigned_unit() and i_1:controller_wrapper():get_input_bool("show_alternative_hud") then
			l_19_2 = true
		end
	end
	l_19_0._show_current_mission_objective = l_19_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


