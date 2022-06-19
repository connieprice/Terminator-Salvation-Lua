require("shared/TypeConverter")
RailVehicleSeat = RailVehicleSeat or class()
function RailVehicleSeat.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5
	A0_0._name = L2_2
	for L5_5 in L2_2(L3_3) do
		A0_0:_parse_node(L5_5)
	end
end
function RailVehicleSeat._parse_node(A0_6, A1_7)
	local L2_8, L3_9, L4_10
	L3_9 = A1_7
	L2_8 = A1_7.parameter
	L4_10 = "name"
	L2_8 = L2_8(L3_9, L4_10)
	L4_10 = A1_7
	L3_9 = A1_7.parameter
	L3_9 = L3_9(L4_10, "value")
	L4_10 = A1_7.parameter
	L4_10 = L4_10(A1_7, "type")
	A0_6["_" .. L2_8] = TypeConverter:convert(L3_9, L4_10)
end
function RailVehicleSeat.set_unit(A0_11, A1_12)
	A0_11._player_unit = A1_12
end
function RailVehicleSeat.get_unit(A0_13)
	local L1_14
	L1_14 = A0_13._player_unit
	return L1_14
end
function RailVehicleSeat.remove_unit(A0_15)
	local L1_16
	A0_15._player_unit = nil
end
function RailVehicleSeat.is_empty(A0_17)
	return A0_17._player_unit == nil
end
function RailVehicleSeat.get_offset(A0_18)
	if A0_18._offset == nil then
		A0_18._offset = Vector3(A0_18._x_offset, A0_18._y_offset, A0_18._z_offset)
	end
	return A0_18._offset
end
function RailVehicleSeat.get_rotation(A0_19)
	local L1_20
	L1_20 = A0_19._rotation
	return L1_20
end
function RailVehicleSeat.set_rotation(A0_21, A1_22)
	A0_21._rotation = A1_22
end
function RailVehicleSeat.get_animation(A0_23)
	local L1_24
	L1_24 = A0_23._animation
	return L1_24
end
function RailVehicleSeat.get_name(A0_25)
	local L1_26
	L1_26 = A0_25._name
	return L1_26
end
function RailVehicleSeat.get_state_name(A0_27)
	local L1_28
	L1_28 = A0_27._state
	return L1_28
end
function RailVehicleSeat.get_right_constraint(A0_29)
	local L1_30
	L1_30 = 180
	return L1_30
end
function RailVehicleSeat.get_left_constraint(A0_31)
	local L1_32
	L1_32 = 180
	return L1_32
end
function RailVehicleSeat.get_aim_constraints(A0_33)
	local L1_34, L2_35
	L1_34 = 180
	L2_35 = 180
	return L1_34, L2_35
end
function RailVehicleSeat.get_align_object(A0_36)
	local L1_37
	L1_37 = A0_36._align_object
	return L1_37
end
function RailVehicleSeat.get_exit_to(A0_38)
	local L1_39
	L1_39 = A0_38._exit_to
	return L1_39
end
