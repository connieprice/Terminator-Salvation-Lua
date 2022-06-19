local L0_0
L0_0 = require
L0_0("shared/TableAlgorithms")
L0_0 = RumbleManager
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
RumbleManager = L0_0
L0_0 = RumbleManager
function L0_0.init(A0_1)
	A0_1._listeners = {}
	A0_1._listeners_id = 0
	A0_1._listeners_count = 0
	A0_1._effects = {}
	A0_1._effects_id = 0
	A0_1._effects_count = 0
	A0_1._presets = {}
	A0_1:load_presets()
end
function L0_0(A0_2, A1_3)
	return math.clamp(A0_2 / A1_3, 0, 1)
end
function RumbleManager.presets(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9
	L1_5 = {}
	for L5_9, 