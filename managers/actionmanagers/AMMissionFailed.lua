if not AMMissionFailed then
	AMMissionFailed = class(CoreActionElement)
end
AMMissionFailed.activate_now = function(l_1_0)
	managers.game_transition:game_over()
end


