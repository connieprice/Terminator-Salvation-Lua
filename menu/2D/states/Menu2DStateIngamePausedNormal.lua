require("menu/2D/states/Menu2DStateIngamePaused")
if not Menu2DStateIngamePausedNormal then
	Menu2DStateIngamePausedNormal = class(Menu2DStateIngamePaused)
end
Menu2DStateIngamePausedNormal.init = function(l_1_0)
	Menu2DStateIngamePaused.init(l_1_0, Menu2DStateIngamePausedNormal)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("pause")
end


