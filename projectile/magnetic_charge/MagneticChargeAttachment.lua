require("units/attachment/Attachment")
MagneticChargeAttachment = MagneticChargeAttachment or class(Attachment)
function MagneticChargeAttachment.init(A0_0, A1_1)
	Attachment.init(A0_0, A1_1)
	A0_0._body = A0_0._unit:body(A0_0._body_name)
end
function MagneticChargeAttachment.attached_to_unit(A0_2, A1_3)
	A0_2._body:set_keyframed()
end
function MagneticChargeAttachment.detached_from_unit(A0_4, A1_5)
	A0_4._body:set_dynamic()
end
