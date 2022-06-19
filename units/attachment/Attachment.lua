require("units/attachment/AttachmentPoint")
if not Attachment then
	Attachment = class()
end
Attachment.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0:_create_attachment_points()
end

Attachment.destroy = function(l_2_0, l_2_1)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	for i_0,i_1 in pairs(l_2_0._attachment_points) do
		i_1:destroy()
	end
end

Attachment.attachment_points = function(l_3_0)
	return l_3_0._attachment_points
end

Attachment.attachment_point = function(l_4_0, l_4_1)
	return l_4_0._attachment_points[l_4_1]
end

Attachment._create_attachment_points = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	l_5_0._attachment_points = {}
	if not l_5_0._attachment_point_object_names then
		return 
	end
	for i_0,i_1 in pairs(l_5_0._attachment_point_object_names) do
		assert(l_5_0._unit:get_object(i_1))
		l_5_0._attachment_points[l_5_8] = AttachmentPoint:new(l_5_0._unit, l_5_8, l_5_0._unit:get_object(i_1))
	end
end

Attachment.attached_to_unit = function(l_6_0, l_6_1)
end

Attachment.detached_from_unit = function(l_7_0, l_7_1)
end


