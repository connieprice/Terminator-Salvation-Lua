if not DelayedWeaponLogicSetup then
	DelayedFiringWeaponLogicSetup = class()
end
DelayedFiringWeaponLogicSetup.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0.prepare_redirect = l_1_1
	l_1_0.unprepare_redirect = l_1_2
	l_1_0.prepared_variable_name = l_1_3
	l_1_0.keep_prepared_time = l_1_4
end


