CameraSetupNode = CameraSetupNode or class()
function CameraSetupNode.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._class_name = A1_1
	A0_0._settings = A2_2
	A0_0._children = A3_3
end
function CameraSetupNode.class_name(A0_4)
	local L1_5
	L1_5 = A0_4._class_name
	return L1_5
end
function CameraSetupNode.settings(A0_6)
	local L1_7
	L1_7 = A0_6._settings
	return L1_7
end
function CameraSetupNode.children(A0_8)
	local L1_9
	L1_9 = A0_8._children
	return L1_9
end
