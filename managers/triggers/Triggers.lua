require("managers/triggers/UnitDeathTrigger")
require("managers/triggers/MissionObjectiveTimedOutTrigger")
require("managers/triggers/UnitStatusTrigger")
require("managers/triggers/MoviePlayedTrigger")
require("managers/triggers/AiWaypointTriggerReachedTrigger")
require("managers/triggers/SceneTrigger")
require("managers/triggers/MenuTrigger")
Triggers = Triggers or {}
function Triggers.init(A0_0)
	A0_0:add_trigger("UnitDeath", UnitDeathTrigger)
	A0_0:add_trigger("MissionObjective", MissionObjectiveTimedOutTrigger)
	A0_0:add_trigger("UnitStatus", UnitStatusTrigger)
	A0_0:add_trigger("Movie", MoviePlayedTrigger)
	A0_0:add_trigger("AiWaypointTriggerReachedTrigger", AiWaypointTriggerReachedTrigger)
	A0_0:add_trigger("SceneTrigger", SceneTrigger)
	A0_0:add_trigger("MenuTrigger", MenuTrigger)
end