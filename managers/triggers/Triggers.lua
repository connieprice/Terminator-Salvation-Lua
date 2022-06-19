require("managers/triggers/UnitDeathTrigger")
require("managers/triggers/MissionObjectiveTimedOutTrigger")
require("managers/triggers/UnitStatusTrigger")
require("managers/triggers/MoviePlayedTrigger")
require("managers/triggers/AiWaypointTriggerReachedTrigger")
require("managers/triggers/SceneTrigger")
require("managers/triggers/MenuTrigger")
if not Triggers then
	Triggers = {}
end
Triggers.init = function(l_1_0)
	l_1_0:add_trigger("UnitDeath", UnitDeathTrigger)
	l_1_0:add_trigger("MissionObjective", MissionObjectiveTimedOutTrigger)
	l_1_0:add_trigger("UnitStatus", UnitStatusTrigger)
	l_1_0:add_trigger("Movie", MoviePlayedTrigger)
	l_1_0:add_trigger("AiWaypointTriggerReachedTrigger", AiWaypointTriggerReachedTrigger)
	l_1_0:add_trigger("SceneTrigger", SceneTrigger)
	l_1_0:add_trigger("MenuTrigger", MenuTrigger)
end


