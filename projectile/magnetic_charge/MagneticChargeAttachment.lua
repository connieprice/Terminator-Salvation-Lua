require("units/attachment/Attachment")
if not MagneticChargeAttachment then
	MagneticChargeAttachment = class(Attachment)
end
MagneticChargeAttachment.init = function(l_1_0, l_1_1)
	Attachment.init(l_1_0, l_1_1)
	l_1_0._body = l_1_0._unit:body(l_1_0._body_name)
end

MagneticChargeAttachment.attached_to_unit = function(l_2_0, l_2_1)
	l_2_0._body:set_keyframed()
end

MagneticChargeAttachment.detached_from_unit = function(l_3_0, l_3_1)
	l_3_0._body:set_dynamic()
end


