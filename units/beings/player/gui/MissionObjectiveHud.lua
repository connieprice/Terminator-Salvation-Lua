require("units/beings/player/gui/HudPlayerObjective")
require("units/beings/player/gui/TopToBottomHudElementStack")
MissionObjectiveHud = MissionObjectiveHud or class()
function MissionObjectiveHud.init(A0_0, A1_1)
	local L2_2
	L2_2 = 2
	A0_0._mission_objective_stack = TopToBottomHudElementStack:new(A1_1, L2_2)
	Localizer:load("data/strings/mission_objectives.xml")
	A0_0._hud_objectives = {}
end
function MissionObjectiveHud.destroy(A0_3)
	local L1_4
end
function MissionObjectiveHud.update(A0_5, A1_6, A2_7)
	local L3_8, L4_9, L5_10, L6_11, L7_12, L8_13
	for L6_11, L7_12 in L3_8(L4_9) do
		L8_13 = A0_5._hud_objectives
		L8_13 = L8_13[L7_12:objective():id()]
		if not L8_13 then
			L8_13 = HudPlayerObjective:new(A0_5._mission_objective_stack, L7_12, A0_5._use_small_font)
			A0_5._hud_objectives[L7_12:objective():id()] = L8_13
		end
		L8_13:update()
	end
	L3_8(L4_9, L5_10)
end
function MissionObjectiveHud.use_small_font(A0_14)
	local L1_15
	A0_14._use_small_font = true
end
function MissionObjectiveHud.use_normal_font(A0_16)
	local L1_17
	A0_16._use_small_font = false
end
function MissionObjectiveHud.use_top_align(A0_18, A1_19)
	A0_18._mission_objective_stack:use_top_align(A1_19)
end
