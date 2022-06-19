require("shared/Interpolator")
if not InterpolatorLinear then
	InterpolatorLinear = class(Interpolator)
end
InterpolatorLinear.init = function(l_1_0, l_1_1, l_1_2)
	Interpolator.init(l_1_0, l_1_1, l_1_2)
end

InterpolatorLinear.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._target - l_2_0._value
	if l_2_2 > 0 then
		l_2_0._value = l_2_0._value + math.min(l_2_0._speed * l_2_1, l_2_2)
	else
		l_2_0._value = l_2_0._value + math.max(-l_2_0._speed * l_2_1, l_2_2)
	end
end


