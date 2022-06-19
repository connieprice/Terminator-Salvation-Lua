AMWorldCamera = AMWorldCamera or class(CoreAMWorldCamera)
function AMWorldCamera.init(A0_0, A1_1, A2_2)
	CoreAMWorldCamera.init(A0_0, A1_1, A2_2)
end
function AMWorldCamera.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8
	L1_4 = false
	for L5_8 = 1, 2 do
		if managers.player_slot:slot(L5_8) and managers.player_slot:slot(L5_8):spawned_unit() and managers.player_slot:slot(L5_8):spawned_unit():player_data().rail_vehicle_permanent_camera then
			A0_3:deactivate_now()
			return
		end
	end
	L2_5(L3_6)
end
