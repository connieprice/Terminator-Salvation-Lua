require("units/beings/player/gui/HudPlayerObjective")
require("units/beings/player/gui/TopToBottomHudElementStack")
if not MissionObjectiveHud then
	MissionObjectiveHud = class()
end
MissionObjectiveHud.init = function(l_1_0, l_1_1)
	local l_1_2 = 2
	l_1_0._mission_objective_stack = TopToBottomHudElementStack:new(l_1_1, l_1_2)
	Localizer:load("data/strings/mission_objectives.xml")
	l_1_0._hud_objectives = {}
end

MissionObjectiveHud.destroy = function(l_2_0)
end

MissionObjectiveHud.update = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_15, l_3_16, l_3_18, l_3_19 = nil
	for i_0,i_1 in pairs(l_3_2) do
		if not l_3_0._hud_objectives[i_1:objective():id()] then
			local l_3_20 = HudPlayerObjective:new(l_3_0._mission_objective_stack, i_1, l_3_0._use_small_font)
			l_3_0._hud_objectives[l_3_17:objective():id()] = l_3_20
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_3_20:update()
	end
	l_3_0._mission_objective_stack:update(l_3_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MissionObjectiveHud.use_small_font = function(l_4_0)
	l_4_0._use_small_font = true
end

MissionObjectiveHud.use_normal_font = function(l_5_0)
	l_5_0._use_small_font = false
end

MissionObjectiveHud.use_top_align = function(l_6_0, l_6_1)
	l_6_0._mission_objective_stack:use_top_align(l_6_1)
end


