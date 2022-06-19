require("shared/camera/SharedCamera")
if not UnitLinkCamera then
	UnitLinkCamera = class(SharedCamera)
end
UnitLinkCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._link_x = nil
	l_1_0._link_y = nil
	l_1_0._link_z = nil
	l_1_0._link_rot = nil
end

UnitLinkCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.link then
		if not l_2_0._root_unit:get_object(l_2_1.link) and l_2_1.link == "orientation_object" then
			local l_2_2, l_2_3, l_2_4 = l_2_0._root_unit:orientation_object()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_x = l_2_2
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_y = l_2_2
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_z = l_2_2
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_rot = l_2_2
	end
	if l_2_1.link_x and not l_2_0._root_unit:get_object(l_2_1.link_x) and l_2_1.link == "orientation_object" then
		l_2_0._link_x = l_2_0._root_unit:orientation_object()
	end
	if l_2_1.link_y and not l_2_0._root_unit:get_object(l_2_1.link_y) and l_2_1.link == "orientation_object" then
		l_2_0._link_y = l_2_0._root_unit:orientation_object()
	end
	if l_2_1.link_z and not l_2_0._root_unit:get_object(l_2_1.link_z) and l_2_1.link == "orientation_object" then
		l_2_0._link_z = l_2_0._root_unit:orientation_object()
	end
	if l_2_1.link_pos then
		if not l_2_0._root_unit:get_object(l_2_1.link_pos) and l_2_1.link == "orientation_object" then
			local l_2_5, l_2_6 = l_2_0._root_unit:orientation_object()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_x = l_2_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_y = l_2_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0._link_z = l_2_5
	end
	if l_2_1.link_rot and not l_2_0._root_unit:get_object(l_2_1.link_rot) and l_2_1.link == "orientation_object" then
		l_2_0._link_rot = l_2_0._root_unit:orientation_object()
	end
end

UnitLinkCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_5 = l_3_0._local_position
	mvector3.set_zero(l_3_5)
	local l_3_6 = l_3_0._link_x
	if l_3_6 then
		mvector3.set_x(l_3_5, l_3_6:position().x)
	end
	l_3_6 = l_3_0._link_y
	if l_3_6 then
		mvector3.set_y(l_3_5, l_3_6:position().y)
	end
	l_3_6 = l_3_0._link_z
	if l_3_6 then
		mvector3.set_z(l_3_5, l_3_6:position().z)
	end
	l_3_6 = l_3_0._link_rot
	if l_3_6 then
		l_3_0._local_rotation = l_3_6:rotation()
	else
		mrotation.set_zero(l_3_0._local_rotation)
	end
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end


