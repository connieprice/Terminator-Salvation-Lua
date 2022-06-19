if not MenuStateIngamePausingForCutscene then
	MenuStateIngamePausingForCutscene = class(MenuStateIngamePausing)
end
MenuStateIngamePausingForCutscene.transition = function(l_1_0)
	return MenuStateIngamePaused
end


