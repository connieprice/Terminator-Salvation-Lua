AMMissionFailed = AMMissionFailed or class(CoreActionElement)
function AMMissionFailed.activate_now(A0_0)
	managers.game_transition:game_over()
end
