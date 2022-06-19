require("units/attachment/AttachmentPoint")
Attachment = Attachment or class()
function Attachment.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0:_create_attachment_points()
end
function Attachment.destroy(A0_2, A1_3)
	for 