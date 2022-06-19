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
function check_for_host_or_join_session()
	if managers.game_transition:wants_to_host_session() then
		return GameStateWaitingForAllUserProfiles
	elseif managers.game_transition:wants_to_join_session() then
		return GameStateWaitingForMenuSyncStart
	end
end
function set_level_name_from_profile()
	local L0_0, L1_1, L2_2, L3_3, L4_4, L5_5
	L2_2 = managers
	L2_2 = L2_2.save
	L3_3 = L2_2
	L2_2 = L2_2.profile
	L2_2 = L2_2(L3_3)
	L3_3 = L2_2.current_level_id
	L1_1 = L2_2.current_checkpoint_id
	L4_4 = nil
	L5_5 = L2_2.debug_level_name
	if L5_5 then
		L4_4 = L2_2.debug_level_name
	else
		L5_5 = managers
		L5_5 = L5_5.world_info
		L5_5 = L5_5.info_from_id
		L5_5 = L5_5(L5_5, L3_3)
		assert(L5_5)
		L4_4 = L5_5.name
	end
	L5_5 = cat_print
	L5_5("debug", "Session provider set level: '" .. L4_4 .. "'")
	L5_5 = managers
	L5_5 = L5_5.network
	L5_5 = L5_5.host
	L5_5 = L5_5(L5_5)
	L5_5 = L5_5.session_provider
	L5_5 = L5_5(L5_5)
	L5_5 = L5_5.set_level_name
	L5_5(L5_5, L4_4, L1_1)
end
