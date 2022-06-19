require("user/SessionUserManager")
require("local_user/LocalSessionUserManager")
require("mission_objective/MissionObjectiveManager")
require("managers/DynamicMusicManager")
require("director/DirectorManager")
require("setups/DirectorManagerSetup")
require("managers/GameRulesManager")
if not SessionManager then
	SessionManager = class()
end
SessionManager.init = function(l_1_0)
	local l_1_1 = {}
	SessionUserManager.default_data(l_1_1)
	managers.session_user = SessionUserManager:new(l_1_1)
	managers.user_viewport = UserViewportManager:new(managers.menu:root_panel())
	managers.splittable_viewport = SplittableViewportManager:new()
	managers.mission_objective = MissionObjectiveManager:new()
	managers.network = NetworkManager:new()
end

SessionManager.destroy = function(l_2_0)
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

SessionManager.update = function(l_3_0, l_3_1, l_3_2)
	managers.session_user:update()
	managers.local_session_user:update()
	managers.user_viewport:update(l_3_2)
	managers.splittable_viewport:update(l_3_2)
	if managers.network:wants_to_load_world() then
		managers.network:ack_load_world()
	end
	managers.network:update(l_3_2)
end

SessionManager.render = function(l_4_0)
	managers.user_viewport:render()
	managers.splittable_viewport:render()
end


