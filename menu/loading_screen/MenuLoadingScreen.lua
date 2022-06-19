require("menu/loading_screen/LoadingScreen")
if not MenuLoadingScreen then
	MenuLoadingScreen = class(LoadingScreen)
end
MenuLoadingScreen.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	LoadingScreen.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	local l_1_8, l_1_9 = l_1_0._panel:rect, l_1_0._panel
	local l_1_10 = {}
	l_1_10.color = Color.black
	l_1_10.layer = 1
	l_1_10.render_template = "OverlayVertexColor"
	l_1_8(l_1_9, l_1_10)
end


