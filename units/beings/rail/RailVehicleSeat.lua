require("shared/TypeConverter")
if not RailVehicleSeat then
	RailVehicleSeat = class()
end
RailVehicleSeat.init = function(l_1_0, l_1_1)
	local l_1_5, l_1_6 = nil
	l_1_0._name = l_1_1:parameter("name")
	for i_0 in l_1_1:children() do
		l_1_0:_parse_node(i_0)
	end
end

RailVehicleSeat._parse_node = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:parameter("name")
	local l_2_3 = l_2_1:parameter("value")
	local l_2_4 = l_2_1:parameter("type")
	local l_2_5 = "_" .. l_2_2
	l_2_0[l_2_5] = TypeConverter:convert(l_2_3, l_2_4)
end

RailVehicleSeat.set_unit = function(l_3_0, l_3_1)
	l_3_0._player_unit = l_3_1
end

RailVehicleSeat.get_unit = function(l_4_0)
	return l_4_0._player_unit
end

RailVehicleSeat.remove_unit = function(l_5_0)
	l_5_0._player_unit = nil
end

RailVehicleSeat.is_empty = function(l_6_0)
	return l_6_0._player_unit == nil
end

RailVehicleSeat.get_offset = function(l_7_0)
	if l_7_0._offset == nil then
		l_7_0._offset = Vector3(l_7_0._x_offset, l_7_0._y_offset, l_7_0._z_offset)
	end
	return l_7_0._offset
end

RailVehicleSeat.get_rotation = function(l_8_0)
	return l_8_0._rotation
end

RailVehicleSeat.set_rotation = function(l_9_0, l_9_1)
	l_9_0._rotation = l_9_1
end

RailVehicleSeat.get_animation = function(l_10_0)
	return l_10_0._animation
end

RailVehicleSeat.get_name = function(l_11_0)
	return l_11_0._name
end

RailVehicleSeat.get_state_name = function(l_12_0)
	return l_12_0._state
end

RailVehicleSeat.get_right_constraint = function(l_13_0)
	return 180
end

RailVehicleSeat.get_left_constraint = function(l_14_0)
	return 180
end

RailVehicleSeat.get_aim_constraints = function(l_15_0)
	return 180, 180
end

RailVehicleSeat.get_align_object = function(l_16_0)
	return l_16_0._align_object
end

RailVehicleSeat.get_exit_to = function(l_17_0)
	return l_17_0._exit_to
end


