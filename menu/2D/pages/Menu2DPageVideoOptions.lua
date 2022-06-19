require("menu/2D/pages/Menu2DPageNormal")
if not Menu2DPageVideoOptions then
	Menu2DPageVideoOptions = class(Menu2DPageNormal)
end
local l_0_0 = Menu2DPageVideoOptions
local l_0_1 = {}
local l_0_2 = {}
l_0_2.x = 4
l_0_2.y = 3
local l_0_3 = {}
l_0_3.x = 5
l_0_3.y = 4
local l_0_4 = {}
l_0_4.x = 16
l_0_4.y = 9
local l_0_5 = {}
l_0_5.x = 16
l_0_5.y = 10
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0.aspect_ratios = l_0_1
l_0_0 = Menu2DPageVideoOptions
l_0_1 = function(l_1_0, ...)
	l_1_0:_populate_resolutions()
	l_1_0:_populate_aspect_ratios()
	Menu2DPageNormal.open(l_1_0, ...)
end

l_0_0.open = l_0_1
l_0_0 = Menu2DPageVideoOptions
l_0_1 = function(l_2_0)
	local l_2_1, l_2_2, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18, l_2_19, l_2_20, l_2_21 = nil, nil
	local l_2_3 = RenderSettings.resolution
	l_2_0:_find_choice("resolution"):widget():clear()
	for i_0,i_1 in pairs(RenderSettings.modes) do
		local l_2_4, l_2_5 = nil
		if i_1.x == l_2_3.x and i_1.y == l_2_3.y and i_1.z == l_2_3.z then
			l_2_5:add_choice({text = i_1.x .. "x" .. i_1.y .. " (" .. i_1.z .. ")", ignore_localization = true})
		end
		l_2_5:set_selected_choice(l_2_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 35 
end

l_0_0._populate_resolutions = l_0_1
l_0_0 = Menu2DPageVideoOptions
l_0_1 = function(l_3_0)
	local l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17 = nil
	local l_3_1 = 0.01
	local l_3_2 = l_3_0:_find_choice("aspect_ratio")
	local l_3_3 = l_3_2:widget()
	l_3_3:clear()
	local l_3_4, l_3_5 = nil, nil
	local l_3_6 = core_setup.aspect_ratio
	for i_0,i_1 in pairs(Menu2DPageVideoOptions.aspect_ratios) do
		if math.abs(i_1.x / i_1.y - l_3_6) < l_3_1 and (not l_3_5 or math.abs(i_1.x / i_1.y - l_3_6) < l_3_5) then
			l_3_4 = l_3_18
			l_3_5 = math.abs(i_1.x / i_1.y - l_3_6)
		end
		l_3_3:add_choice({text = i_1.x .. ":" .. i_1.y, ignore_localization = true})
	end
	do
		local l_3_20 = {}
		l_3_3:add_choice(l_3_20)
		if managers.save:profile().video_settings.auto_aspect_ratio then
			l_3_4 = #Menu2DPageVideoOptions.aspect_ratios + 1
		end
		l_3_3:set_selected_choice(l_3_20)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0._populate_aspect_ratios = l_0_1
l_0_0 = Menu2DPageVideoOptions
l_0_1 = function(l_4_0)
	local l_4_1 = l_4_0:_find_choice("resolution"):widget()
	local l_4_2 = l_4_0:_find_choice("aspect_ratio"):widget()
	local l_4_3 = managers.menu2d:menu_island_instance_data()
	l_4_3.video_mode = RenderSettings.modes[l_4_1:selected_choice()]
	local l_4_4 = l_4_2:selected_choice()
	if #Menu2DPageVideoOptions.aspect_ratios < l_4_4 then
		l_4_3.auto_aspect_ratio = true
		l_4_3.aspect_ratio = nil
	else
		local l_4_5 = Menu2DPageVideoOptions.aspect_ratios[l_4_4]
		l_4_3.auto_aspect_ratio = false
		l_4_3.aspect_ratio = l_4_5.x / l_4_5.y
	end
end

l_0_0.set_island_data = l_0_1

