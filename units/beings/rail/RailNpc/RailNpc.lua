if not RailNpc then
	RailNpc = class()
end
RailNpc.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._anim_machine = l_1_0._unit:anim_state_machine()
end

RailNpc.set_vehicle = function(l_2_0, l_2_1)
	l_2_0._vehicle = l_2_1
end

RailNpc.ragdoll = function(l_3_0)
	local l_3_7, l_3_8, l_3_9, l_3_10, l_3_13 = nil
	local l_3_1 = {}
	l_3_1.rag_Hips = "Hips"
	l_3_1.rag_Head = "Head"
	l_3_1.rag_LeftUpLeg = "LeftUpLeg"
	l_3_1.rag_RightUpLeg = "RightUpLeg"
	l_3_1.rag_LeftLeg = "LeftLeg"
	l_3_1.rag_RightLeg = "RightLeg"
	l_3_1.rag_Spine = "Spine1"
	l_3_1.rag_Spine2 = "Spine2"
	l_3_1.rag_LeftForeArm = "LeftForeArm"
	l_3_1.rag_RightForeArm = "RightForeArm"
	l_3_1.rag_LeftArm = "LeftArm"
	l_3_1.rag_RightArm = "RightArm"
	local l_3_2 = {}
	local l_3_3 = {}
	for i_0,i_1 in pairs(l_3_1) do
		l_3_2[l_3_11] = l_3_0._unit:body(i_1):velocity()
		l_3_3[l_3_11] = l_3_0._unit:body(i_1):angular_velocity()
	end
	l_3_0._unit:set_animatable_enabled("all", false)
	local l_3_12 = l_3_0._unit
	managers.sequence:run_sequence_simple("ragdoll", l_3_12)
	for l_3_12,i_1 in pairs(l_3_1) do
		do
			l_3_0._unit:body(l_3_12):set_velocity(l_3_2[l_3_12] * 2)
			l_3_0._unit:body(l_3_12):set_angular_velocity(l_3_3[l_3_12])
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailNpc.remove = function(l_4_0)
	l_4_0._vehicle = nil
	l_4_0._unit:set_slot(0)
end

RailNpc.destroy = function(l_5_0)
	l_5_0._unit = nil
end

RailNpc.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
end


