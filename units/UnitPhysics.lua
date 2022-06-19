UnitPhysics = UnitPhysics or class()
function UnitPhysics.init(A0_0, A1_1)
	A0_0._unit = A1_1
end
function UnitPhysics.push(A0_2, A1_3, A2_4, A3_5)
	A0_2._unit:push(A1_3, A2_4)
end
