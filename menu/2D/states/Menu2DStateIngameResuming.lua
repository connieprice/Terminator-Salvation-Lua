require("menu/2D/states/Menu2DState")
if not Menu2DStateIngameResuming then
	Menu2DStateIngameResuming = class(Menu2DState)
end
Menu2DStateIngameResuming.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateIngameResuming)
end


