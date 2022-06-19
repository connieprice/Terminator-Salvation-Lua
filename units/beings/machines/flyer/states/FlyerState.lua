FlyerState = FlyerState or class()
function FlyerState.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._base = A1_1:base()
	A0_0._emitter = A1_1:base()._emitter
end
