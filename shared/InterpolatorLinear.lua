require("shared/Interpolator")
InterpolatorLinear = InterpolatorLinear or class(Interpolator)
function InterpolatorLinear.init(A0_0, A1_1, A2_2)
	Interpolator.init(A0_0, A1_1, A2_2)
end
function InterpolatorLinear.update(A0_3, A1_4)
	local L2_5, L3_6
	L2_5 = A0_3._target
	L3_6 = A0_3._value
	L2_5 = L2_5 - L3_6
	if L2_5 > 0 then
		L3_6 = A0_3._value
		L3_6 = L3_6 + math.min(A0_3._speed * A1_4, L2_5)
		A0_3._value = L3_6
	else
		L3_6 = A0_3._value
		L3_6 = L3_6 + math.max(-A0_3._speed * A1_4, L2_5)
		A0_3._value = L3_6
	end
end
