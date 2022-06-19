require("shared/aimer/Aimer")
if not InstantBulletAimer then
	InstantBulletAimer = class(Aimer)
end
InstantBulletAimer.aim_position = function(l_1_0, l_1_1, l_1_2)
	return l_1_2
end


