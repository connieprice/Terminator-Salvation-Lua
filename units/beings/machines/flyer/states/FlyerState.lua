if not FlyerState then
	FlyerState = class()
end
FlyerState.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	local l_1_2 = l_1_1:base()
	l_1_0._base = l_1_2
	l_1_0._emitter = l_1_2._emitter
end


