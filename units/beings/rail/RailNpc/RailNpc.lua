RailNpc = RailNpc or class()
function RailNpc.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._anim_machine = A0_0._unit:anim_state_machine()
end
function RailNpc.set_vehicle(A0_2, A1_3)
	A0_2._vehicle = A1_3
end
function RailNpc.ragdoll(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L1_5 = {}
	L1_5.rag_Hips = "Hips"
	L1_5.rag_Head = "Head"
	L1_5.rag_LeftUpLeg = "LeftUpLeg"
	L1_5.rag_RightUpLeg = "RightUpLeg"
	L1_5.rag_LeftLeg = "LeftLeg"
	L1_5.rag_RightLeg = "RightLeg"
	L1_5.rag_Spine = "Spine1"
	L1_5.rag_Spine2 = "Spine2"
	L1_5.rag_LeftForeArm = "LeftForeArm"
	L1_5.rag_RightForeArm = "RightForeArm"
	L1_5.rag_LeftArm = "LeftArm"
	L1_5.rag_RightArm = "RightArm"
	L2_6 = {}
	L3_7 = {}
	for L7_11, L8_12 in L4_8(L5_9) do
		L2_6[L7_11] = A0_4._unit:body(L8_12):velocity()
		L3_7[L7_11] = A0_4._unit:body(L8_12):angular_velocity()
	end
	L7_11 = false
	L4_8(L5_9, L6_10, L7_11)
	L7_11 = A0_4._unit
	L4_8(L5_9, L6_10, L7_11)
	for L7_11, L8_12 in L4_8(L5_9) do
		A0_4._unit:body(L7_11):set_velocity(L2_6[L7_11] * 2)
		A0_4._unit:body(L7_11):set_angular_velocity(L3_7[L7_11])
	end
end
function RailNpc.remove(A0_13)
	A0_13._vehicle = nil
	A0_13._unit:set_slot(0)
end
function RailNpc.destroy(A0_14)
	local L1_15
	A0_14._unit = nil
end
function RailNpc.update(A0_16, A1_17, A2_18, A3_19)
end
