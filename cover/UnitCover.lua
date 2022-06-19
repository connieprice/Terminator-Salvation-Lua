require("cover/CoverBody")
require("utils/ListHelper")
UnitCover = UnitCover or class()
if Application:editor() then
	UnitCover.update = UnitCover.update or function(A0_0)
		if A0_0._unit:position() ~= A0_0._position or A0_0._unit:rotation() ~= A0_0._rotation then
			A0_0:_unregister()
			A0_0:_register()
		end
	end
end
function UnitCover.init(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1:_register()
end
function UnitCover.destroy(A0_3)
	A0_3:_unregister()
end
function UnitCover.get_covers(A0_4)
	local L1_5
	L1_5 = {}
	for 