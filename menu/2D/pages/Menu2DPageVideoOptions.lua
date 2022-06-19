require("menu/2D/pages/Menu2DPageNormal")
Menu2DPageVideoOptions = Menu2DPageVideoOptions or class(Menu2DPageNormal)
Menu2DPageVideoOptions.aspect_ratios = {
	{x = 4, y = 3},
	{x = 5, y = 4},
	{x = 16, y = 9},
	{x = 16, y = 10}
}
function Menu2DPageVideoOptions.open(A0_0, ...)
	A0_0:_populate_resolutions()
	A0_0:_populate_aspect_ratios()
	Menu2DPageNormal.open(A0_0, ...)
end
function Menu2DPageVideoOptions._populate_resolutions(A0_2)
	local L1_3, L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L10_12, L11_13, L12_14
	L3_5 = RenderSettings
	L3_5 = L3_5.resolution
	L5_7 = A0_2
	L4_6 = A0_2._find_choice
	L4_6 = L4_6(L5_7, L6_8)
	L5_7 = L4_6.widget
	L5_7 = L5_7(L6_8)
	L6_8(L7_9)
	for L9_11, L10_12 in L6_8(L7_9) do
		L11_13 = L10_12.x
		L12_14 = "x"
		L11_13 = L11_13 .. L12_14 .. L10_12.y .. " (" .. L10_12.z .. ")"
		L12_14 = L10_12.x
		if L12_14 == L3_5.x then
			L12_14 = L10_12.y
			if L12_14 == L3_5.y then
				L12_14 = L10_12.z
				if L12_14 == L3_5.z then
					L2_4 = L9_11
				end
			end
		end
		L12_14 = {}
		L12_14.text = L11_13
		L12_14.ignore_localization = true
		L5_7:add_choice(L12_14)
	end
	L6_8(L7_9, L8_10)
end
function Menu2DPageVideoOptions._populate_aspect_ratios(A0_15)
	local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L11_26, L12_27
	L1_16 = 0.01
	L3_18 = A0_15
	L2_17 = A0_15._find_choice
	L4_19 = "aspect_ratio"
	L2_17 = L2_17(L3_18, L4_19)
	L4_19 = L2_17
	L3_18 = L2_17.widget
	L3_18 = L3_18(L4_19)
	L5_20 = L3_18
	L4_19 = L3_18.clear
	L4_19(L5_20)
	L4_19, L5_20 = nil, nil
	L6_21 = core_setup
	L6_21 = L6_21.aspect_ratio
	for L10_25, L11_26 in L7_22(L8_23) do
		L12_27 = {}
		L12_27.text = L11_26.x .. ":" .. L11_26.y
		L12_27.ignore_localization = true
		if L1_16 > math.abs(L11_26.x / L11_26.y - L6_21) and (not L5_20 or L5_20 > math.abs(L11_26.x / L11_26.y - L6_21)) then
			L5_20, L4_19 = math.abs(L11_26.x / L11_26.y - L6_21), L10_25
		end
		L3_18:add_choice(L12_27)
	end
	L10_25 = {}
	L10_25.text = "menu_auto_aspect_ratio"
	L10_25.ignore_localization = false
	L8_23(L9_24, L10_25)
	if L8_23 then
		L4_19 = L8_23 + 1
	end
	L10_25 = L4_19
	L8_23(L9_24, L10_25)
end
function Menu2DPageVideoOptions.set_island_data(A0_28)
	managers.menu2d:menu_island_instance_data().video_mode = RenderSettings.modes[A0_28:_find_choice("resolution"):widget():selected_choice()]
	if A0_28:_find_choice("aspect_ratio"):widget():selected_choice() > #Menu2DPageVideoOptions.aspect_ratios then
		managers.menu2d:menu_island_instance_data().auto_aspect_ratio = true
		managers.menu2d:menu_island_instance_data().aspect_ratio = nil
	else
		managers.menu2d:menu_island_instance_data().auto_aspect_ratio = false
		managers.menu2d:menu_island_instance_data().aspect_ratio = Menu2DPageVideoOptions.aspect_ratios[A0_28:_find_choice("aspect_ratio"):widget():selected_choice()].x / Menu2DPageVideoOptions.aspect_ratios[A0_28:_find_choice("aspect_ratio"):widget():selected_choice()].y
	end
end
