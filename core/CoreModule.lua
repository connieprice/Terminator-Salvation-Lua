local L0_0, L1_1, L2_2
L0_0 = 0
L1_1 = 1
L2_2 = {}
L2_2.PRODUCTION_ONLY = "PRODUCTION_ONLY"
function L2_2.new(A0_3)
	local L1_4
	L1_4 = {}
	setmetatable(L1_4, A0_3)
	L1_4:init()
	return L1_4
end
function L2_2.init(A0_5)
	A0_5._core_modules = {}
	A0_5._core_file_paths = {}
	A0_5._core_meta_data = {}
	A0_5._proj_modules = {}
	A0_5._proj_file_paths = {}
	A0_5._proj_meta_data = {}
	A0_5._next_module_type = {}
	A0_5._pristine_G = {}
	for 