require("shared/camera/SharedCamera")
UnitLinkCamera = UnitLinkCamera or class(SharedCamera)
function UnitLinkCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._link_x = nil
	A0_0._link_y = nil
	A0_0._link_z = nil
	A0_0._link_rot = nil
end
function UnitLinkCamera.parse_parameters(A0_2, A1_3)
	local L2_4
	L2_4 = SharedCamera
	L2_4 = L2_4.parse_parameters
	L2_4(A0_2, A1_3)
	L2_4 = A1_3.link
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_x = L2_4
		A0_2._link_y = L2_4
		A0_2._link_z = L2_4
		A0_2._link_rot = L2_4
	end
	L2_4 = A1_3.link_x
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link_x)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_x = L2_4
	end
	L2_4 = A1_3.link_y
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link_y)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_y = L2_4
	end
	L2_4 = A1_3.link_z
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link_z)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_z = L2_4
	end
	L2_4 = A1_3.link_pos
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link_pos)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_x = L2_4
		A0_2._link_y = L2_4
		A0_2._link_z = L2_4
	end
	L2_4 = A1_3.link_rot
	if L2_4 then
		L2_4 = A0_2._root_unit
		L2_4 = L2_4.get_object
		L2_4 = L2_4(L2_4, A1_3.link_rot)
		if not L2_4 and A1_3.link == "orientation_object" then
			L2_4 = A0_2._root_unit:orientation_object()
		end
		A0_2._link_rot = L2_4
	end
end
function UnitLinkCamera.update(A0_5, A1_6, A2_7, A3_8, A4_9)
	local L5_10
	L5_10 = A0_5._local_position
	mvector3.set_zero(L5_10)
	if A0_5._link_x then
		mvector3.set_x(L5_10, A0_5._link_x:position().x)
	end
	if A0_5._link_y then
		mvector3.set_y(L5_10, A0_5._link_y:position().y)
	end
	if A0_5._link_z then
		mvector3.set_z(L5_10, A0_5._link_z:position().z)
	end
	if A0_5._link_rot then
		A0_5._local_rotation = A0_5._link_rot:rotation()
	else
		mrotation.set_zero(A0_5._local_rotation)
	end
	SharedCamera.update(A0_5, A1_6, A2_7, A3_8, A4_9)
end
