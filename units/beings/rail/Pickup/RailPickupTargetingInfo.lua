require("units/beings/TargetingInfo")
RailPickupTargetingInfo = RailPickupTargetingInfo or class(TargetingInfo)
function RailPickupTargetingInfo.init(A0_0, A1_1)
	TargetingInfo.init(A0_0, A1_1)
end
function RailPickupTargetingInfo.primary_target_position(A0_2)
	return A0_2._default_objects[math.random(1, #A0_2._default_objects)]:position()
end
function RailPickupTargetingInfo._target_object(A0_3, A1_4, A2_5, A3_6)
	for 