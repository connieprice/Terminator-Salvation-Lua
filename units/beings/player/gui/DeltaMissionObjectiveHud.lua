require("units/beings/player/gui/HudPlayerObjective")
require("units/beings/player/gui/TopToBottomHudElementStack")
require("units/beings/player/gui/MissionObjectiveHud")
DeltaMissionObjectiveHud = DeltaMissionObjectiveHud or class(MissionObjectiveHud)
function DeltaMissionObjectiveHud.init(A0_0, A1_1, A2_2)
	MissionObjectiveHud.init(A0_0, A2_2)
	A0_0._hud_objectives_completed = {}
	A0_0._hud_timers = {}
	A0_0._hud_objective_shown = {}
	A0_0._unit = A1_1
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
end
function DeltaMissionObjectiveHud.destroy(A0_3)
	A0_3._emitter:destroy()
end
function DeltaMissionObjectiveHud._add_objective(A0_4, A1_5)
	A0_4._hud_objectives[A1_5:objective():id()] = HudPlayerObjective:new(A0_4._mission_objective_stack, A1_5, A0_4._use_small_font)
	A0_4._hud_timers[A1_5:objective():id()] = 0
end
function DeltaMissionObjectiveHud._has_objective(A0_6, A1_7)
	return A0_6._hud_objectives[A1_7:objective():id()] ~= nil
end
function DeltaMissionObjectiveHud.update(A0_8, A1_9, A2_10)
	local L3_11, L4_12, L5_13, L6_14, L7_15, L8_16
	L3_11 = {}
	for L7_15, L8_16 in L4_12(L5_13) do
		L3_11[L8_16:objective():id()] = true
		if not A0_8:_has_objective(L8_16) then
			A0_8:_add_objective(L8_16)
			A0_8._emitter:unit_hud_mission_objective_new(A0_8._unit)
		elseif L8_16:is_completed() and not A0_8._hud_objectives_completed[L8_16:objective():id()] then
			A0_8._hud_objectives[L8_16:objective():id()]:destroy()
			A0_8._hud_objectives[L8_16:objective():id()] = nil
			A0_8:_add_objective(L8_16)
			A0_8._hud_objectives_completed[L8_16:objective():id()] = true
			A0_8._emitter:unit_hud_mission_objective_completed(A0_8._unit)
		end
	end
	for L7_15, L8_16 in L4_12(L5_13) do
		if not L3_11[L7_15] then
			L8_16:destroy()
			A0_8._hud_objectives[L7_15] = nil
		else
			A0_8._hud_timers[L7_15] = A0_8._hud_timers[L7_15] + A1_9
			if A0_8._hud_timers[L7_15] > 3 then
				L8_16:destroy()
			else
				L8_16:update_icon_pulse(A1_9)
				L8_16:update_mover(A1_9)
			end
		end
	end
	L4_12(L5_13, L6_14)
end
function DeltaMissionObjectiveHud.use_small_font(A0_17)
	local L1_18
	A0_17._use_small_font = true
end
function DeltaMissionObjectiveHud.use_normal_font(A0_19)
	local L1_20
	A0_19._use_small_font = false
end
