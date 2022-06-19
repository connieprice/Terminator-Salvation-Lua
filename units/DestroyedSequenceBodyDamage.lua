require("units/DestroyableBodyDamage")
if not DestroyedSequenceBodyDamage then
	DestroyedSequenceBodyDamage = class(DestroyableBodyDamage)
end
DestroyedSequenceBodyDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	DestroyableBodyDamage.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	l_1_0._destroyed_sequence_name = l_1_8
end

DestroyedSequenceBodyDamage.destroyed = function(l_2_0)
	DestroyableBodyDamage.destroyed(l_2_0)
	managers.sequence:run_sequence_simple(l_2_0._destroyed_sequence_name, l_2_0._unit)
end


