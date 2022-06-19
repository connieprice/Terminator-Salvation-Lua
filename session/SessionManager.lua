require("user/SessionUserManager")
require("local_user/LocalSessionUserManager")
require("mission_objective/MissionObjectiveManager")
require("managers/DynamicMusicManager")
require("director/DirectorManager")
require("setups/DirectorManagerSetup")
require("managers/GameRulesManager")
SessionManager = SessionManager or class()
function SessionManager.init(A0_0)
	local L1_1
	L1_1 = {}
	SessionUserManager.default_data(L1_1)
	managers.session_user = SessionUserManager:new(L1_1)
	managers.user_viewport = UserViewportManager:new(managers.menu:root_panel())
	managers.splittable_viewport = SplittableViewportManager:new()
	managers.mission_objective = MissionObjectiveManager:new()
	managers.network = NetworkManager:new()
end
function SessionManager.destroy(A0_2)
	managers.network:destroy()
	managers.network = nil
	managers.session_user:destroy()
	managers.session_user = nil
	managers.splittable_viewport:destroy()
	managers.splittable_viewport = nil
	managers.user_viewport:destroy()
	managers.user_viewport = nil
	managers.mission_objective:destroy()
	managers.mission_objective = nil
end
function SessionManager.update(A0_3, A1_4, A2_5)
	managers.session_user:update()
	managers.local_session_user:update()
	managers.user_viewport:update(A2_5)
	managers.splittable_viewport:update(A2_5)
	if managers.network:wants_to_load_world() then
		managers.network:ack_load_world()
	end
	managers.network:update(A2_5)
end
function SessionManager.render(A0_6)
	managers.user_viewport:render()
	managers.splittable_viewport:render()
end
