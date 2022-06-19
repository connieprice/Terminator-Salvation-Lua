require("shared/camera/SharedCamera")
require("shared/Interpolator")
if not DofCamera then
	DofCamera = class(SharedCamera)
end
DofCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._dof_interpolator = Interpolator:new(0, 30)
end

DofCamera.activate = function(l_2_0)
	l_2_0._player_data = l_2_0._root_unit:player_data()
end

DofCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	if not l_3_0._player_data then
		return 
	end
	l_3_0:update_dof(l_3_3)
end

DofCamera.update_dof = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._player_data.camera_position
	local l_4_3 = l_4_0._player_data.aim_target_position
	if not l_4_3 then
		return 
	end
	local l_4_4 = l_4_3 - l_4_2:length()
	l_4_0._dof_interpolator:set_target(l_4_4)
	l_4_0._dof_interpolator:update(l_4_1)
	l_4_0.dof = {}
	l_4_0.dof.near_min = 1
	l_4_0.dof.near_max = 300
	l_4_0.dof.far_min = math.max(l_4_0._dof_interpolator:value() + 20000, 1)
	l_4_0.dof.far_max = 80000
	l_4_0.dof.amount = 0.2
end


