local L0_0, L1_1
L0_0 = SensoryEventManagerSetup
L0_0 = L0_0 or {}
SensoryEventManagerSetup = L0_0
L0_0 = SensoryEventManagerSetup
function L1_1(A0_2)
	SensoryEventManagerSetup._setup_event_types(A0_2)
end
L0_0.setup = L1_1
L0_0 = SensoryEventManagerSetup
function L1_1(A0_3)
	A0_3:define_source_type("MACHINE")
	A0_3:define_source_type("HUMAN")
	A0_3:define_source_type("GENERIC_WEAPON")
	A0_3:define_source_type("HUMAN_WEAPON")
	A0_3:define_source_type("MACHINE_WEAPON")
	A0_3:define_source_type("UNKNOWN")
end
L0_0._setup_event_types = L1_1
