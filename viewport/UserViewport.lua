UserViewport = UserViewport or class()
function UserViewport.preload()
	local L0_0, L1_1, L2_2
	L0_0 = UserViewport
	L1_1 = {}
	L0_0._indoor_environments = L1_1
	L0_0 = File
	L1_1 = L0_0
	L0_0 = L0_0.new_parse_xml
	L0_0 = L0_0(L1_1, L2_2)
	L1_1 = L0_0.children
	L1_1 = L1_1(L2_2)
	for 