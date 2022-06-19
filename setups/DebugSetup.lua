require("setups/Setup")
require("debug/DebugViewAndControl")
require("units/UnitAnimationRecorder")
require("debug/DebugCommands")
local l_0_0 = nil
if not Global.category_debug_render then
	Global.category_debug_render = {}
end
if not Global.category_debug_render_initialized then
	Global.category_debug_render_initialized = {}
end
Global.debug_setup_init = false
if not debug_commands then
	debug_commands = DebugCommands:new()
end
parse_ai_parameters = function()
		local l_1_3, l_1_4 = ipairs, Application:argv()
		l_1_3 = l_1_3(l_1_4)
		for i_0,i_1 in l_1_3 do
			if l_1_2 == "-test_done" then
				unit_test.browser = CoreUnitTestBrowser:new()
				unit_test.browser._autorun = true
				do return end
			elseif l_1_2 == "-test" and managers.aihivebrain then
				managers.aihivebrain:set_enable(false)
		else
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
setup_category_debug_render = function()
	local l_2_4, l_2_5 = nil
	if Global.category_debug_render_initialized.setup then
		return 
	end
	Global.category_debug_render.ai = false
	local l_2_0 = setup.get_people_list()
	for i_0,i_1 in ipairs(l_2_0) do
		Global.category_debug_render[i_1] = false
	end
	Global.category_debug_render_initialized.setup = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

parse_level_parameters = function()
	-- upvalues: l_0_0
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20, l_3_21, l_3_22, l_3_23 = nil
	local l_3_0 = Application:argv()
	local l_3_1 = {}
	cat_print("debug", "Parsing executable parameters")
	for i_0,i_1 in ipairs(l_3_0) do
		if i_1 == "-zone" then
			l_3_1.zone = l_3_0[i_0 + 1]
		elseif i_1 == "-class" then
			l_3_1.class = l_3_0[i_0 + 1]
			if l_3_1.class and rawget(_G, l_3_1.class) then
				l_0_0 = _G[l_3_1.class]:new()
			end
		elseif i_1 == "-load_menu" then
			l_3_1.pass_through_menu = true
		elseif i_1 == "-cycle_levels" then
			l_3_1.should_cycle_levels = true
		elseif i_1 == "-difficulty" then
			l_3_1.difficulty_level = tonumber(l_3_0[i_0 + 1])
		end
	end
	return l_3_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

init = function()
	Global.level_info = parse_level_parameters()
	Menu.is_production_mode = true
	setup_category_debug_render()
	parse_ai_parameters()
	setup.init()
	if not script_debug._info_box then
		script_debug._info_box = DebugInfo:new()
	end
	script_debug._ai = false
	script_debug._look_acc = true
end

debug_set_level_to_profile = function()
	if not Global.level_info then
		return 
	end
	if Global.level_info.zone then
		local l_5_0 = managers.save:profile()
		managers.save:set_level_data_to_profiles(nil, 1, Global.level_info.zone, true)
		l_5_0.difficulty_level = Global.level_info.difficulty_level or 1
	else
		cat_print("debug", "Did not set level to primary profile!")
	end
end

update = function(l_6_0, l_6_1)
	-- upvalues: l_0_0
	setup.update(l_6_0, l_6_1)
	if l_0_0 and l_0_0.update then
		l_0_0:update(l_6_0, l_6_1)
	end
	script_debug._info_box:update(l_6_0, l_6_1)
end

paused_update = function(l_7_0, l_7_1)
	setup.paused_update(l_7_0, l_7_1)
	script_debug._info_box:update(l_7_0, l_7_1)
end

render = function()
	setup.render()
end

pre_init = function()
	setup.pre_init()
end

save = function(l_10_0)
	setup.save(l_10_0)
end

load = function(l_11_0)
	setup.load(l_11_0)
end


