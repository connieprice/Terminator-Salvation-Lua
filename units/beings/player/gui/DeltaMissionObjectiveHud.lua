require("units/beings/player/gui/HudPlayerObjective")
require("units/beings/player/gui/TopToBottomHudElementStack")
require("units/beings/player/gui/MissionObjectiveHud")
if not DeltaMissionObjectiveHud then
	DeltaMissionObjectiveHud = class(MissionObjectiveHud)
end
DeltaMissionObjectiveHud.init = function(l_1_0, l_1_1, l_1_2)
	MissionObjectiveHud.init(l_1_0, l_1_2)
	l_1_0._hud_objectives_completed = {}
	l_1_0._hud_timers = {}
	l_1_0._hud_objective_shown = {}
	l_1_0._unit = l_1_1
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
end

DeltaMissionObjectiveHud.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
end

DeltaMissionObjectiveHud._add_objective = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1:objective():id()
	local l_3_3 = HudPlayerObjective:new(l_3_0._mission_objective_stack, l_3_1, l_3_0._use_small_font)
	l_3_0._hud_objectives[l_3_2] = l_3_3
	l_3_0._hud_timers[l_3_2] = 0
end

DeltaMissionObjectiveHud._has_objective = function(l_4_0, l_4_1)
	local l_4_2 = l_4_1:objective():id()
	local l_4_3 = l_4_0._hud_objectives[l_4_2]
	return l_4_3 ~= nil
end

DeltaMissionObjectiveHud.update = function(l_5_0, l_5_1, l_5_2)
	local l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_13, l_5_14, l_5_17, l_5_18, l_5_19, l_5_20, l_5_21, l_5_22, l_5_23, l_5_24, l_5_25, l_5_26, l_5_27, l_5_28, l_5_29, l_5_30, l_5_31, l_5_32, l_5_33, l_5_34, l_5_35, l_5_36, l_5_37, l_5_38, l_5_39 = nil
	local l_5_3 = {}
	for i_0,i_1 in pairs(l_5_2) do
		l_5_3[i_1:objective():id()] = true
		if not l_5_0:_has_objective(i_1) then
			l_5_0:_add_objective(i_1)
			l_5_0._emitter:unit_hud_mission_objective_new(l_5_0._unit)
		else
			if i_1:is_completed() and not l_5_0._hud_objectives_completed[i_1:objective():id()] then
				l_5_0._hud_objectives[i_1:objective():id()]:destroy()
				l_5_0._hud_objectives[i_1:objective():id()] = nil
				l_5_0:_add_objective(l_5_16)
				l_5_0._hud_objectives_completed[i_1:objective():id()] = true
				l_5_0._emitter:unit_hud_mission_objective_completed(l_5_0._unit)
			end
		end
	end
	for i_0,i_1 in pairs(l_5_0._hud_objectives) do
		if not l_5_3[i_0] then
			i_1:destroy()
			l_5_0._hud_objectives[i_0] = nil
		else
			l_5_0._hud_timers[i_0] = l_5_0._hud_timers[i_0] + l_5_1
			if l_5_0._hud_timers[i_0] > 3 then
				i_1:destroy()
			end
		else
			i_1:update_icon_pulse(l_5_1)
			i_1:update_mover(l_5_1)
		end
	end
	l_5_0._mission_objective_stack:update(l_5_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DeltaMissionObjectiveHud.use_small_font = function(l_6_0)
	l_6_0._use_small_font = true
end

DeltaMissionObjectiveHud.use_normal_font = function(l_7_0)
	l_7_0._use_small_font = false
end


