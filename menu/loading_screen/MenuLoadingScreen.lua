require("menu/loading_screen/LoadingScreen")
MenuLoadingScreen = MenuLoadingScreen or class(LoadingScreen)
function MenuLoadingScreen.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	LoadingScreen.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	A0_0._panel:rect({
		color = Color.black,
		layer = 1,
		render_template = "OverlayVertexColor"
	})
end
