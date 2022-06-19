require("shared/camera/SharedCamera")
if not StaticDistanceDofCamera then
	StaticDistanceDofCamera = class(SharedCamera)
end
StaticDistanceDofCamera.parse_parameters = function(l_1_0, l_1_1)
	SharedCamera.parse_parameters(l_1_0, l_1_1)
	l_1_0._near_min = tonumber(l_1_1.near_min)
	assert(l_1_0._near_min)
	l_1_0._near_max = tonumber(l_1_1.near_max)
	assert(l_1_0._near_max)
	l_1_0._far_min = tonumber(l_1_1.far_min)
	assert(l_1_0._far_min)
	l_1_0._far_max = tonumber(l_1_1.far_max)
	assert(l_1_0._far_max)
	l_1_0._amount = tonumber(l_1_1.amount)
	assert(l_1_0._amount)
	l_1_0:_update_dof()
end

StaticDistanceDofCamera._update_dof = function(l_2_0)
	local l_2_1 = {}
	l_2_1.near_min = l_2_0._near_min
	l_2_1.near_max = l_2_0._near_max
	l_2_1.far_min = l_2_0._far_min
	l_2_1.far_max = l_2_0._far_max
	l_2_1.amount = l_2_0._amount
	l_2_0.dof = l_2_1
end


