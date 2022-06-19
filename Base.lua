local L1_0
function L1_0(A0_1)
	if not alive(A0_1) then
		return true
	end
	return A0_1:damage_data():is_fully_damaged()
end
dead = L1_0
