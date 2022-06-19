require("shared/camera/SharedCamera")
require("shared/Interpolator")
DofCamera = DofCamera or class(SharedCamera)
function DofCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._dof_interpolator = Interpolator:new(0, 30)
end
function DofCamera.activate(A0_2)
	A0_2._player_data = A0_2._root_unit:player_data()
end
function DofCamera.update(A0_3, A1_4, A2_5, A3_6)
	SharedCamera.update(A0_3, A1_4, A2_5, A3_6)
	if not A0_3._player_data then
		return
	end
	A0_3:update_dof(A3_6)
end
function DofCamera.update_dof(A0_7, A1_8)
	local L2_9, L3_10, L4_11
	L2_9 = A0_7._player_data
	L2_9 = L2_9.camera_position
	L3_10 = A0_7._player_data
	L3_10 = L3_10.aim_target_position
	if not L3_10 then
		return
	end
	L4_11 = L3_10 - L2_9
	L4_11 = L4_11.length
	L4_11 = L4_11(L4_11)
	A0_7._dof_interpolator:set_target(L4_11)
	A0_7._dof_interpolator:update(A1_8)
	A0_7.dof = {}
	A0_7.dof.near_min = 1
	A0_7.dof.near_max = 300
	A0_7.dof.far_min = math.max(A0_7._dof_interpolator:value() + 20000, 1)
	A0_7.dof.far_max = 80000
	A0_7.dof.amount = 0.2
end
