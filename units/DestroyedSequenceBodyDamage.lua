require("units/DestroyableBodyDamage")
DestroyedSequenceBodyDamage = DestroyedSequenceBodyDamage or class(DestroyableBodyDamage)
function DestroyedSequenceBodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	DestroyableBodyDamage.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	A0_0._destroyed_sequence_name = A8_8
end
function DestroyedSequenceBodyDamage.destroyed(A0_9)
	DestroyableBodyDamage.destroyed(A0_9)
	managers.sequence:run_sequence_simple(A0_9._destroyed_sequence_name, A0_9._unit)
end
