SequenceUnitDamage = SequenceUnitDamage or class(UnitDamage)
function SequenceUnitDamage.dead(A0_0, A1_1)
	managers.sequence:run_sequence_simple(A0_0._death_sequence, A0_0._unit)
end
