require("cover/CoverBox")
require("utils/ListHelper")
CoverBody = CoverBody or class()
function CoverBody.init(A0_0, A1_1)
	A0_0._body = A1_1
	A0_0:_extract_cover_boxes()
end
function CoverBody.get_covers(A0_2)
	local L1_3
	L1_3 = A0_2._body
	L1_3 = L1_3.enabled
	L1_3 = L1_3(L1_3)
	if not L1_3 then
		L1_3 = {}
		return L1_3
	end
	L1_3 = {}
	for 