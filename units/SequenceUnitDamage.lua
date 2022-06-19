if not SequenceUnitDamage then
	SequenceUnitDamage = class(UnitDamage)
end
SequenceUnitDamage.dead = function(l_1_0, l_1_1)
	managers.sequence:run_sequence_simple(l_1_0._death_sequence, l_1_0._unit)
end


