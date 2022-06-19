require("menu/2D/Menu2DAnimations")
Menu2DDistortion = Menu2DDistortion or class()
function Menu2DDistortion.init(A0_0)
	local L1_1
	L1_1 = tweak_data
	L1_1 = L1_1.menu2d
	L1_1 = L1_1.distortion_animation_names
	A0_0._animation_names = L1_1
	L1_1 = {}
	A0_0._animations = L1_1
	L1_1 = A0_0._animations
	L1_1.flash = Menu2DAnimations.flash_distortion
	L1_1 = A0_0._animations
	L1_1.idle = Menu2DAnimations.idle
	L1_1 = A0_0._animations
	L1_1.twitch = Menu2DAnimations.twitch
	L1_1 = {
		"gui_menu_distortion_01",
		"gui_menu_distortion_02",
		"gui_menu_distortion_03",
		"gui_menu_distortion_04"
	}
	A0_0._textures = L1_1
	L1_1 = tweak_data
	L1_1 = L1_1.menu2d
	L1_1 = L1_1.distortion
	L1_1 = L1_1.max_distortion_objects
	A0_0._max_nr_of_bitmaps = L1_1
end
function Menu2DDistortion.set_parent(A0_2, A1_3)
	A0_2._parent = A1_3
	A0_2._panel = A1_3:panel({
		layer = tweak_data.menu2d.layer_distortion
	})
	A0_2._w = A0_2._panel:w()
	A0_2._h = A0_2._panel:h()
end
function Menu2DDistortion.start(A0_4)
	A0_4:create_gui()
end
function Menu2DDistortion.create_gui(A0_5)
	local L1_6
	L1_6 = {}
	A0_5._bitmaps = L1_6
	L1_6 = nil
	for _FORV_5_ = 1, A0_5._max_nr_of_bitmaps do
		L1_6 = A0_5._panel:bitmap({})
		L1_6:hide()
		table.insert(A0_5._bitmaps, L1_6)
	end
	A0_5._normal_map = _FOR_:bitmap({
		name = "normal_map",
		texture = "gui_menu_normal_distortion",
		render_template = "heat_shimmer",
		w = A0_5._panel:w(),
		h = A0_5._panel:h() * 0.9,
		layer = 99999
	})
	A0_5._normal_map:hide()
end
function Menu2DDistortion.update(A0_7, A1_8, A2_9)
	local L3_10, L4_11, L5_12, L6_13, L7_14
	L3_10 = A0_7._in_burst
	if L3_10 then
		L3_10 = {}
		for L7_14, 