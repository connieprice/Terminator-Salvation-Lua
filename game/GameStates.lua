require("shared/FiniteStateMachineState")
require("menu/LoadMenu")
require("game/states/GameStateClearWorld")
require("game/states/GameStatePreFrontend")
require("game/states/GameStateFrontend")
require("game/states/GameStateHostGame")
require("game/states/GameStateInEditor")
require("game/states/GameStateInGame")
require("game/states/GameStateInSession")
require("game/states/GameStateJoinSession")
require("game/states/GameStateLeaveSession")
require("game/states/GameStateLoadWorld")
require("game/states/GameStateLoadingWorld")
require("game/states/GameStateStabilizing")
require("game/states/GameStateWaitingForMenuSyncStart")
require("game/states/GameStateWaitingForMenuSyncToFinish")
require("game/states/GameStateInit")
require("game/states/GameStateWaitingForPrimaryProfile")
require("game/states/GameStateWaitingForPrimaryUser")
require("game/states/GameStateWorldCleared")
require("game/states/GameStateInEditorSimulation")
require("game/states/GameStateInSessionLobby")
require("game/states/GameStateWaitingForAllUserProfiles")
check_for_host_or_join_session = function()
	if managers.game_transition:wants_to_host_session() then
		return GameStateWaitingForAllUserProfiles
	else
		if managers.game_transition:wants_to_join_session() then
			return GameStateWaitingForMenuSyncStart
		end
	end
end

set_level_name_from_profile = function()
	local l_2_0, l_2_1 = nil, nil
	local l_2_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_2_2.debug_level_name then
		do return end
	end
	do
		local l_2_3 = nil
		assert(managers.world_info:info_from_id(managers.save:profile().current_level_id))
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	cat_print("debug", "Session provider set level: '" .. nil .. "'")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.network:host():session_provider():set_level_name(nil, l_2_1)
end


