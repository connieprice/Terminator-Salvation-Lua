require("menu/2D/Menu2DPage")
Menu2DPageNormal = Menu2DPageNormal or class(Menu2DPage)
function Menu2DPageNormal.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._screen = Menu2DScreen:new(A0_0._panel, A0_0)
	A0_0._time_since_move = 0
end
function Menu2DPageNormal.post_init(A0_3)
	for 