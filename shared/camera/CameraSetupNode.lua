if not CameraSetupNode then
	CameraSetupNode = class()
end
CameraSetupNode.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._class_name = l_1_1
	l_1_0._settings = l_1_2
	l_1_0._children = l_1_3
end

CameraSetupNode.class_name = function(l_2_0)
	return l_2_0._class_name
end

CameraSetupNode.settings = function(l_3_0)
	return l_3_0._settings
end

CameraSetupNode.children = function(l_4_0)
	return l_4_0._children
end


