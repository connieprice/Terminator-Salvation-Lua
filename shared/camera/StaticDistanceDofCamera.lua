require("shared/camera/SharedCamera")
StaticDistanceDofCamera = StaticDistanceDofCamera or class(SharedCamera)
function StaticDistanceDofCamera.parse_parameters(A0_0, A1_1)
	SharedCamera.parse_parameters(A0_0, A1_1)
	A0_0._near_min = tonumber(A1_1.near_min)
	assert(A0_0._near_min)
	A0_0._near_max = tonumber(A1_1.near_max)
	assert(A0_0._near_max)
	A0_0._far_min = tonumber(A1_1.far_min)
	assert(A0_0._far_min)
	A0_0._far_max = tonumber(A1_1.far_max)
	assert(A0_0._far_max)
	A0_0._amount = tonumber(A1_1.amount)
	assert(A0_0._amount)
	A0_0:_update_dof()
end
function StaticDistanceDofCamera._update_dof(A0_2)
	local L1_3, L2_4
	L1_3 = {}
	L2_4 = A0_2._near_min
	L1_3.near_min = L2_4
	L2_4 = A0_2._near_max
	L1_3.near_max = L2_4
	L2_4 = A0_2._far_min
	L1_3.far_min = L2_4
	L2_4 = A0_2._far_max
	L1_3.far_max = L2_4
	L2_4 = A0_2._amount
	L1_3.amount = L2_4
	A0_2.dof = L1_3
end
