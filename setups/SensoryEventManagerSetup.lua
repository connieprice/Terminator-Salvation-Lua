if not SensoryEventManagerSetup then
	SensoryEventManagerSetup = {}
end
SensoryEventManagerSetup.setup = function(l_1_0)
	SensoryEventManagerSetup._setup_event_types(l_1_0)
end

SensoryEventManagerSetup._setup_event_types = function(l_2_0)
	l_2_0:define_source_type("MACHINE")
	l_2_0:define_source_type("HUMAN")
	l_2_0:define_source_type("GENERIC_WEAPON")
	l_2_0:define_source_type("HUMAN_WEAPON")
	l_2_0:define_source_type("MACHINE_WEAPON")
	l_2_0:define_source_type("UNKNOWN")
end


