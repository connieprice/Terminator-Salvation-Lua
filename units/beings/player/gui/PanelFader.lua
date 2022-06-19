require("shared/Interpolator")
PanelFader = PanelFader or class()
function PanelFader.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	L4_4 = 0
	if A2_2 then
		L4_4 = A2_2
	end
	A3_3 = A3_3 or 100
	A0_0._alpha = Interpolator:new(L4_4, A3_3)
	A0_0._panel = A1_1
end
function PanelFader.update(A0_5, A1_6)
	local L2_7
	L2_7 = A0_5._alpha
	L2_7 = L2_7.update
	L2_7(L2_7, A1_6)
	L2_7 = A0_5._alpha
	L2_7 = L2_7.value
	L2_7 = L2_7(L2_7)
	A0_5:_fade_children(A0_5._panel:children(), L2_7)
end
function PanelFader._fade_children(A0_8, A1_9, A2_10)
	for 